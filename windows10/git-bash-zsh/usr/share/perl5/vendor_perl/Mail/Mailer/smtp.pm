# Copyrights 1995-2019 by [Mark Overmeer <markov@cpan.org>].
#  For other contributors see ChangeLog.
# See the manual pages for details on the licensing terms.
# Pod stripped from pm file by OODoc 2.02.
# This code is part of the bundle MailTools.  Meta-POD processed with
# OODoc into POD and HTML manual-pages.  See README.md for Copyright.
# Licensed under the same terms as Perl itself.

package Mail::Mailer::smtp;
use vars '$VERSION';
$VERSION = '2.21';

use base 'Mail::Mailer::rfc822';

use strict;

use Net::SMTP;
use Mail::Util qw(mailaddress);
use Carp;

sub can_cc { 0 }

sub exec {
    my ($self, $exe, $args, $to) = @_;
    my %opt   = @$args;
    my $host  = $opt{Server} || undef;
    $opt{Debug} ||= 0;

    my $smtp = Net::SMTP->new($host, %opt)
        or return undef;

    if($opt{StartTLS})
    {   $Net::SMTP::VERSION >= 1.28
            or die "StartTLS requires Net::SMTP 1.28";

        $smtp->starttls
            or return undef;
    }

    if($opt{Auth})
    {   $smtp->auth(@{$opt{Auth}})
           or return undef;
    }

    ${*$self}{sock} = $smtp;

    $smtp->mail($opt{From} || mailaddress());
    $smtp->to($_) for @$to;
    $smtp->data;

    untie *$self if tied *$self;
    tie *$self, 'Mail::Mailer::smtp::pipe', $self;
    $self;
}

sub set_headers($)
{   my ($self, $hdrs) = @_;
    $self->SUPER::set_headers
     ( { From => "<" . mailaddress() . ">"
       , %$hdrs
       , 'X-Mailer' => "Mail::Mailer[v$Mail::Mailer::VERSION] Net::SMTP[v$Net::SMTP::VERSION]"
       }
     );
}

sub epilogue()
{   my $self = shift;
    my $sock = ${*$self}{sock};

    my $ok = $sock->dataend;
    $sock->quit;

    delete ${*$self}{sock};
    untie *$self;
    $ok;
}

sub close(@)
{   my ($self, @to) = @_;
    my $sock = ${*$self}{sock};

    $sock && fileno $sock
        or return 1;

    my $ok = $self->epilogue;

    # Epilogue should destroy the SMTP filehandle,
    # but just to be on the safe side.
    $sock && fileno $sock
        or return $ok;

    close $sock
        or croak 'Cannot destroy socket filehandle';

    $ok;
}

package Mail::Mailer::smtp::pipe;
use vars '$VERSION';
$VERSION = '2.21';


sub TIEHANDLE
{   my ($class, $self) = @_;
    my $sock = ${*$self}{sock};
    bless \$sock, $class;
}

sub PRINT
{   my $self = shift;
    my $sock = $$self;
    $sock->datasend( @_ );
}

1;
