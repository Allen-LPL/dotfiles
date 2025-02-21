package Time::Local;

use strict;

use Carp ();
use Exporter;

our $VERSION = '1.30';

use parent 'Exporter';

our @EXPORT    = qw( timegm timelocal );
our @EXPORT_OK = qw(
    timegm_modern
    timelocal_modern
    timegm_nocheck
    timelocal_nocheck
    timegm_posix
    timelocal_posix
);

my @MonthDays = ( 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 );

# Determine breakpoint for rolling century
my $ThisYear    = ( localtime() )[5];
my $Breakpoint  = ( $ThisYear + 50 ) % 100;
my $NextCentury = $ThisYear - $ThisYear % 100;
$NextCentury += 100 if $Breakpoint < 50;
my $Century = $NextCentury - 100;
my $SecOff  = 0;

my ( %Options, %Cheat );

use constant SECS_PER_MINUTE => 60;
use constant SECS_PER_HOUR   => 3600;
use constant SECS_PER_DAY    => 86400;

my $MaxDay;
if ( $] < 5.012000 ) {
    require Config;
    ## no critic (Variables::ProhibitPackageVars)

    my $MaxInt;
    if ( $^O eq 'MacOS' ) {

        # time_t is unsigned...
        $MaxInt = ( 1 << ( 8 * $Config::Config{ivsize} ) )
            - 1;    ## no critic qw(ProhibitPackageVars)
    }
    else {
        $MaxInt
            = ( ( 1 << ( 8 * $Config::Config{ivsize} - 2 ) ) - 1 ) * 2
            + 1;    ## no critic qw(ProhibitPackageVars)
    }

    $MaxDay = int( ( $MaxInt - ( SECS_PER_DAY / 2 ) ) / SECS_PER_DAY ) - 1;
}
else {
    # recent localtime()'s limit is the year 2**31
    $MaxDay = 365 * ( 2**31 );
}

# Determine the EPOC day for this machine
my $Epoc = 0;
if ( $^O eq 'vos' ) {

    # work around posix-977 -- VOS doesn't handle dates in the range
    # 1970-1980.
    $Epoc = _daygm( 0, 0, 0, 1, 0, 70, 4, 0 );
}
elsif ( $^O eq 'MacOS' ) {
    $MaxDay *= 2;    # time_t unsigned ... quick hack?
                     # MacOS time() is seconds since 1 Jan 1904, localtime
                     # so we need to calculate an offset to apply later
    $Epoc   = 693901;
    $SecOff = timelocal( localtime(0) ) - timelocal( gmtime(0) );
    $Epoc += _daygm( gmtime(0) );
}
else {
    $Epoc = _daygm( gmtime(0) );
}

%Cheat = ();         # clear the cache as epoc has changed

sub _daygm {

    # This is written in such a byzantine way in order to avoid
    # lexical variables and sub calls, for speed
    return $_[3] + (
        $Cheat{ pack( 'ss', @_[ 4, 5 ] ) } ||= do {
            my $month = ( $_[4] + 10 ) % 12;
            my $year  = $_[5] + 1900 - int( $month / 10 );

            ( ( 365 * $year )
                + int( $year / 4 )
                    - int( $year / 100 )
                    + int( $year / 400 )
                    + int( ( ( $month * 306 ) + 5 ) / 10 ) ) - $Epoc;
        }
    );
}

sub _timegm {
    my $sec
        = $SecOff + $_[0]
        + ( SECS_PER_MINUTE * $_[1] )
        + ( SECS_PER_HOUR * $_[2] );

    return $sec + ( SECS_PER_DAY * &_daygm );
}

sub timegm {
    my ( $sec, $min, $hour, $mday, $month, $year ) = @_;

    if ( $Options{no_year_munging} ) {
        $year -= 1900;
    }
    elsif ( !$Options{posix_year} ) {
        if ( $year >= 1000 ) {
            $year -= 1900;
        }
        elsif ( $year < 100 and $year >= 0 ) {
            $year += ( $year > $Breakpoint ) ? $Century : $NextCentury;
        }
    }

    unless ( $Options{no_range_check} ) {
        Carp::croak("Month '$month' out of range 0..11")
            if $month > 11
            or $month < 0;

        my $md = $MonthDays[$month];
        ++$md
            if $month == 1 && _is_leap_year( $year + 1900 );

        Carp::croak("Day '$mday' out of range 1..$md")
            if $mday > $md or $mday < 1;
        Carp::croak("Hour '$hour' out of range 0..23")
            if $hour > 23 or $hour < 0;
        Carp::croak("Minute '$min' out of range 0..59")
            if $min > 59 or $min < 0;
        Carp::croak("Second '$sec' out of range 0..59")
            if $sec >= 60 or $sec < 0;
    }

    my $days = _daygm( undef, undef, undef, $mday, $month, $year );

    unless ( $Options{no_range_check} or abs($days) < $MaxDay ) {
        my $msg = q{};
        $msg .= "Day too big - $days > $MaxDay\n" if $days > $MaxDay;

        $year += 1900;
        $msg
            .= "Cannot handle date ($sec, $min, $hour, $mday, $month, $year)";

        Carp::croak($msg);
    }

    return
          $sec + $SecOff
        + ( SECS_PER_MINUTE * $min )
        + ( SECS_PER_HOUR * $hour )
        + ( SECS_PER_DAY * $days );
}

sub _is_leap_year {
    return 0 if $_[0] % 4;
    return 1 if $_[0] % 100;
    return 0 if $_[0] % 400;

    return 1;
}

sub timegm_nocheck {
    local $Options{no_range_check} = 1;
    return &timegm;
}

sub timegm_modern {
    local $Options{no_year_munging} = 1;
    return &timegm;
}

sub timegm_posix {
    local $Options{posix_year} = 1;
    return &timegm;
}

sub timelocal {
    my $ref_t         = &timegm;
    my $loc_for_ref_t = _timegm( localtime($ref_t) );

    my $zone_off = $loc_for_ref_t - $ref_t
        or return $loc_for_ref_t;

    # Adjust for timezone
    my $loc_t = $ref_t - $zone_off;

    # Are we close to a DST change or are we done
    my $dst_off = $ref_t - _timegm( localtime($loc_t) );

    # If this evaluates to true, it means that the value in $loc_t is
    # the _second_ hour after a DST change where the local time moves
    # backward.
    if (
        !$dst_off
        && ( ( $ref_t - SECS_PER_HOUR )
            - _timegm( localtime( $loc_t - SECS_PER_HOUR ) ) < 0 )
    ) {
        return $loc_t - SECS_PER_HOUR;
    }

    # Adjust for DST change
    $loc_t += $dst_off;

    return $loc_t if $dst_off > 0;

    # If the original date was a non-existent gap in a forward DST jump, we
    # should now have the wrong answer - undo the DST adjustment
    my ( $s, $m, $h ) = localtime($loc_t);
    $loc_t -= $dst_off if $s != $_[0] || $m != $_[1] || $h != $_[2];

    return $loc_t;
}

sub timelocal_nocheck {
    local $Options{no_range_check} = 1;
    return &timelocal;
}

sub timelocal_modern {
    local $Options{no_year_munging} = 1;
    return &timelocal;
}

sub timelocal_posix {
    local $Options{posix_year} = 1;
    return &timelocal;
}

1;

# ABSTRACT: Efficiently compute time from local and GMT time

__END__

=pod

=encoding UTF-8

=head1 NAME

Time::Local - Efficiently compute time from local and GMT time

=head1 VERSION

version 1.30

=head1 SYNOPSIS

    use Time::Local qw( timelocal_posix timegm_posix );

    my $time = timelocal_posix( $sec, $min, $hour, $mday, $mon, $year );
    my $time = timegm_posix( $sec, $min, $hour, $mday, $mon, $year );

=head1 DESCRIPTION

This module provides functions that are the inverse of built-in perl functions
C<localtime()> and C<gmtime()>. They accept a date as a six-element array, and
return the corresponding C<time(2)> value in seconds since the system epoch
(Midnight, January 1, 1970 GMT on Unix, for example). This value can be
positive or negative, though POSIX only requires support for positive values,
so dates before the system's epoch may not work on all operating systems.

It is worth drawing particular attention to the expected ranges for the values
provided. The value for the day of the month is the actual day (i.e. 1..31),
while the month is the number of months since January (0..11). This is
consistent with the values returned from C<localtime()> and C<gmtime()>.

=head1 FUNCTIONS

=head2 C<timelocal_posix()> and C<timegm_posix()>

These functions are the exact inverse of Perl's built-in C<localtime> and
C<gmtime> functions. That means that calling C<< timelocal_posix(
localtime($value) ) >> will always give you the same C<$value> you started
with. The same applies to C<< timegm_posix( gmtime($value) ) >>.

The one exception is when the value returned from C<localtime()> represents an
ambiguous local time because of a DST change. See the documentation below for
more details.

These functions expect the year value to be the number of years since 1900,
which is what the C<localtime()> and C<gmtime()> built-ins returns.

They perform range checking by default on the input C<$sec>, C<$min>,
C<$hour>, C<$mday>, and C<$mon> values and will croak (using C<Carp::croak()>)
if given a value outside the allowed ranges.

While it would be nice to make this the default behavior, that would almost
certainly break a lot of code, so you must explicitly import these functions
and use them instead of the default C<timelocal()> and C<timegm()>.

You are B<strongly> encouraged to use these functions in any new code which
uses this module. It will almost certainly make your code's behavior less
surprising.

=head2 C<timelocal_modern()> and C<timegm_modern()>

When C<Time::Local> was first written, it was a common practice to represent
years as a two-digit value like C<99> for C<1999> or C<1> for C<2001>. This
caused all sorts of problems (google "Y2K problem" if you're very young) and
developers eventually realized that this was a terrible idea.

The default exports of C<timelocal()> and C<timegm()> do a complicated
calculation when given a year value less than 1000. This leads to surprising
results in many cases. See L</Year Value Interpretation> for details.

The C<time*_modern()> functions do not do this year munging and simply take
the year value as provided.

They perform range checking by default on the input C<$sec>, C<$min>,
C<$hour>, C<$mday>, and C<$mon> values and will croak (using C<Carp::croak()>)
if given a value outside the allowed ranges.

=head2 C<timelocal()> and C<timegm()>

This module exports two functions by default, C<timelocal()> and C<timegm()>.

They perform range checking by default on the input C<$sec>, C<$min>,
C<$hour>, C<$mday>, and C<$mon> values and will croak (using C<Carp::croak()>)
if given a value outside the allowed ranges.

B<Warning: The year value interpretation that these functions and their
nocheck variants use will almost certainly lead to bugs in your code, if not
now, then in the future. You are strongly discouraged from using these in new
code, and you should convert old code to using either the C<*_posix> or
C<*_modern> functions if possible.>

=head2 C<timelocal_nocheck()> and C<timegm_nocheck()>

If you are working with data you know to be valid, you can use the "nocheck"
variants, C<timelocal_nocheck()> and C<timegm_nocheck()>. These variants must
be explicitly imported.

If you supply data which is not valid (month 27, second 1,000) the results
will be unpredictable (so don't do that).

Note that my benchmarks show that this is just a 3% speed increase over the
checked versions, so unless calling C<Time::Local> is the hottest spot in your
application, using these nocheck variants is unlikely to have much impact on
your application.

=head2 Year Value Interpretation

B<This does not apply to the C<*_posix> or C<*_modern> functions. Use those
exports if you want to ensure consistent behavior as your code ages.>

Strictly speaking, the year should be specified in a form consistent with
C<localtime()>, i.e. the offset from 1900. In order to make the interpretation
of the year easier for humans, however, who are more accustomed to seeing
years as two-digit or four-digit values, the following conventions are
followed:

=over 4

=item *

Years greater than 999 are interpreted as being the actual year, rather than
the offset from 1900. Thus, 1964 would indicate the year Martin Luther King
won the Nobel prize, not the year 3864.

=item *

Years in the range 100..999 are interpreted as offset from 1900, so that 112
indicates 2012. This rule also applies to years less than zero (but see note
below regarding date range).

=item *

Years in the range 0..99 are interpreted as shorthand for years in the rolling
"current century," defined as 50 years on either side of the current
year. Thus, today, in 1999, 0 would refer to 2000, and 45 to 2045, but 55
would refer to 1955. Twenty years from now, 55 would instead refer to
2055. This is messy, but matches the way people currently think about two
digit dates. Whenever possible, use an absolute four digit year instead.

=back

The scheme above allows interpretation of a wide range of dates, particularly
if 4-digit years are used. But it also means that the behavior of your code
changes as time passes, because the rolling "current century" changes each
year.

=head2 Limits of time_t

On perl versions older than 5.12.0, the range of dates that can be actually be
handled depends on the size of C<time_t> (usually a signed integer) on the
given platform. Currently, this is 32 bits for most systems, yielding an
approximate range from Dec 1901 to Jan 2038.

Both C<timelocal()> and C<timegm()> croak if given dates outside the supported
range.

As of version 5.12.0, perl has stopped using the time implementation of the
operating system it's running on. Instead, it has its own implementation of
those routines with a safe range of at least +/- 2**52 (about 142 million
years)

=head2 Ambiguous Local Times (DST)

Because of DST changes, there are many time zones where the same local time
occurs for two different GMT times on the same day. For example, in the
"Europe/Paris" time zone, the local time of 2001-10-28 02:30:00 can represent
either 2001-10-28 00:30:00 GMT, B<or> 2001-10-28 01:30:00 GMT.

When given an ambiguous local time, the timelocal() function will always
return the epoch for the I<earlier> of the two possible GMT times.

=head2 Non-Existent Local Times (DST)

When a DST change causes a locale clock to skip one hour forward, there will
be an hour's worth of local times that don't exist. Again, for the
"Europe/Paris" time zone, the local clock jumped from 2001-03-25 01:59:59 to
2001-03-25 03:00:00.

If the C<timelocal()> function is given a non-existent local time, it will
simply return an epoch value for the time one hour later.

=head2 Negative Epoch Values

On perl version 5.12.0 and newer, negative epoch values are fully supported.

On older versions of perl, negative epoch (C<time_t>) values, which are not
officially supported by the POSIX standards, are known not to work on some
systems. These include MacOS (pre-OSX) and Win32.

On systems which do support negative epoch values, this module should be able
to cope with dates before the start of the epoch, down the minimum value of
time_t for the system.

=head1 IMPLEMENTATION

These routines are quite efficient and yet are always guaranteed to agree with
C<localtime()> and C<gmtime()>. We manage this by caching the start times of
any months we've seen before. If we know the start time of the month, we can
always calculate any time within the month.  The start times are calculated
using a mathematical formula. Unlike other algorithms that do multiple calls
to C<gmtime()>.

The C<timelocal()> function is implemented using the same cache. We just
assume that we're translating a GMT time, and then fudge it when we're done
for the timezone and daylight savings arguments. Note that the timezone is
evaluated for each date because countries occasionally change their official
timezones. Assuming that C<localtime()> corrects for these changes, this
routine will also be correct.

=head1 AUTHORS EMERITUS

This module is based on a Perl 4 library, timelocal.pl, that was
included with Perl 4.036, and was most likely written by Tom
Christiansen.

The current version was written by Graham Barr.

=head1 BUGS

The whole scheme for interpreting two-digit years can be considered a bug.

Bugs may be submitted at L<https://github.com/houseabsolute/Time-Local/issues>.

There is a mailing list available for users of this distribution,
L<mailto:datetime@perl.org>.

I am also usually active on IRC as 'autarch' on C<irc://irc.perl.org>.

=head1 SOURCE

The source code repository for Time-Local can be found at L<https://github.com/houseabsolute/Time-Local>.

=head1 AUTHOR

Dave Rolsky <autarch@urth.org>

=head1 CONTRIBUTORS

=for stopwords Florian Ragwitz J. Nick Koston Unknown

=over 4

=item *

Florian Ragwitz <rafl@debian.org>

=item *

J. Nick Koston <nick@cpanel.net>

=item *

Unknown <unknown@example.com>

=back

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 1997 - 2020 by Graham Barr & Dave Rolsky.

This is free software; you can redistribute it and/or modify it under
the same terms as the Perl 5 programming language system itself.

The full text of the license can be found in the
F<LICENSE> file included with this distribution.

=cut
