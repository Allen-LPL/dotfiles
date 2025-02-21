" Vim syntax file
" Language:    FORTH
" Current Maintainer:  Johan Kotlinski <kotlinski@gmail.com>
" Previous Maintainer:  Christian V. J. Brüssow <cvjb@cvjb.de>
" Last Change: 2018-03-29
" Filenames:   *.fs,*.ft
" URL:	       https://github.com/jkotlinski/forth.vim

" quit when a syntax file was already loaded
if exists("b:current_syntax")
    finish
endif

let s:cpo_save = &cpo
set cpo&vim

" Synchronization method
syn sync ccomment
syn sync maxlines=200

" I use gforth, so I set this to case ignore
syn case ignore

" Some special, non-FORTH keywords
syn keyword forthTodo contained TODO FIXME XXX
syn match forthTodo contained 'Copyright\(\s([Cc])\)\=\(\s[0-9]\{2,4}\)\='

" Characters allowed in keywords
" I don't know if 128-255 are allowed in ANS-FORTH
setlocal iskeyword=!,@,33-35,%,$,38-64,A-Z,91-96,a-z,123-126,128-255

" when wanted, highlight trailing white space
if exists("forth_space_errors")
    if !exists("forth_no_trail_space_error")
        syn match forthSpaceError display excludenl "\s\+$"
    endif
    if !exists("forth_no_tab_space_error")
        syn match forthSpaceError display " \+\t"me=e-1
    endif
endif

" Keywords

" basic mathematical and logical operators
syn keyword forthOperators + - * / MOD /MOD NEGATE ABS MIN MAX
syn keyword forthOperators AND OR XOR NOT LSHIFT RSHIFT INVERT 2* 2/ 1+
syn keyword forthOperators 1- 2+ 2- 8* UNDER+
syn keyword forthOperators M+ */ */MOD M* UM* M*/ UM/MOD FM/MOD SM/REM
syn keyword forthOperators D+ D- DNEGATE DABS DMIN DMAX D2* D2/
syn keyword forthOperators F+ F- F* F/ FNEGATE FABS FMAX FMIN FLOOR FROUND
syn keyword forthOperators F** FSQRT FEXP FEXPM1 FLN FLNP1 FLOG FALOG FSIN
syn keyword forthOperators FCOS FSINCOS FTAN FASIN FACOS FATAN FATAN2 FSINH
syn keyword forthOperators FCOSH FTANH FASINH FACOSH FATANH F2* F2/ 1/F
syn keyword forthOperators F~REL F~ABS F~
syn keyword forthOperators 0< 0<= 0<> 0= 0> 0>= < <= <> = > >= U< U<=
syn keyword forthOperators U> U>= D0< D0<= D0<> D0= D0> D0>= D< D<= D<>
syn keyword forthOperators D= D> D>= DU< DU<= DU> DU>= WITHIN ?NEGATE
syn keyword forthOperators ?DNEGATE TRUE FALSE

" various words that take an input and do something with it
syn keyword forthFunction . U. .R U.R

" stack manipulations
syn keyword forthStack DROP NIP DUP OVER TUCK SWAP ROT -ROT ?DUP PICK ROLL
syn keyword forthStack 2DROP 2NIP 2DUP 2OVER 2TUCK 2SWAP 2ROT 2-ROT
syn keyword forthStack 3DUP 4DUP 5DUP 3DROP 4DROP 5DROP 8DROP 4SWAP 4ROT
syn keyword forthStack 4-ROT 4TUCK 8SWAP 8DUP
syn keyword forthRStack >R R> R@ RDROP 2>R 2R> 2R@ 2RDROP
syn keyword forthRstack 4>R 4R> 4R@ 4RDROP
syn keyword forthFStack FDROP FNIP FDUP FOVER FTUCK FSWAP FROT

" stack pointer manipulations
syn keyword forthSP SP@ SP! FP@ FP! RP@ RP! LP@ LP! DEPTH

" address operations
syn keyword forthMemory @ ! +! C@ C! 2@ 2! F@ F! SF@ SF! DF@ DF!
syn keyword forthAdrArith CHARS CHAR+ CELLS CELL+ CELL ALIGN ALIGNED FLOATS
syn keyword forthAdrArith FLOAT+ FLOAT FALIGN FALIGNED SFLOATS SFLOAT+
syn keyword forthAdrArith SFALIGN SFALIGNED DFLOATS DFLOAT+ DFALIGN DFALIGNED
syn keyword forthAdrArith MAXALIGN MAXALIGNED CFALIGN CFALIGNED
syn keyword forthAdrArith ADDRESS-UNIT-BITS ALLOT ALLOCATE HERE
syn keyword forthMemBlks MOVE ERASE CMOVE CMOVE> FILL BLANK UNUSED

" conditionals
syn keyword forthCond IF ELSE ENDIF THEN CASE OF ENDOF ENDCASE ?DUP-IF
syn keyword forthCond ?DUP-0=-IF AHEAD CS-PICK CS-ROLL CATCH THROW WITHIN

" iterations
syn keyword forthLoop BEGIN WHILE REPEAT UNTIL AGAIN
syn keyword forthLoop ?DO LOOP I J K +DO U+DO -DO U-DO DO +LOOP -LOOP
syn keyword forthLoop UNLOOP LEAVE ?LEAVE EXIT DONE FOR NEXT RECURSE

" new words
syn match forthClassDef '\<:class\s*[^ \t]\+\>'
syn match forthObjectDef '\<:object\s*[^ \t]\+\>'
syn match forthColonDef '\<:m\?\s*[^ \t]\+\>'
syn keyword forthEndOfColonDef ; ;M ;m
syn keyword forthEndOfClassDef ;class
syn keyword forthEndOfObjectDef ;object
syn keyword forthDefine CONSTANT 2CONSTANT FCONSTANT VARIABLE 2VARIABLE
syn keyword forthDefine FVARIABLE CREATE USER VALUE TO DEFER IS DOES> IMMEDIATE
syn keyword forthDefine COMPILE-ONLY COMPILE RESTRICT INTERPRET POSTPONE EXECUTE
syn keyword forthDefine LITERAL CREATE-INTERPRET/COMPILE INTERPRETATION>
syn keyword forthDefine <INTERPRETATION COMPILATION> <COMPILATION ] LASTXT
syn keyword forthDefine COMP' POSTPONE, FIND-NAME NAME>INT NAME?INT NAME>COMP
syn keyword forthDefine NAME>STRING STATE C; CVARIABLE BUFFER: MARKER
syn keyword forthDefine , 2, F, C, COMPILE,
syn match forthDefine "\[IFDEF]"
syn match forthDefine "\[IFUNDEF]"
syn match forthDefine "\[THEN]"
syn match forthDefine "\[ENDIF]"
syn match forthDefine "\[ELSE]"
syn match forthDefine "\[?DO]"
syn match forthDefine "\[DO]"
syn match forthDefine "\[LOOP]"
syn match forthDefine "\[+LOOP]"
syn match forthDefine "\[NEXT]"
syn match forthDefine "\[BEGIN]"
syn match forthDefine "\[UNTIL]"
syn match forthDefine "\[AGAIN]"
syn match forthDefine "\[WHILE]"
syn match forthDefine "\[REPEAT]"
syn match forthDefine "\[COMP']"
syn match forthDefine "'"
syn match forthDefine '\<\[\>'
syn match forthDefine "\[']"
syn match forthDefine '\[COMPILE]'
syn match forthDefine '\[CHAR]'

" debugging
syn keyword forthDebug PRINTDEBUGDATA PRINTDEBUGLINE
syn match forthDebug "\<\~\~\>"

" Assembler
syn keyword forthAssembler ASSEMBLER CODE END-CODE ;CODE FLUSH-ICACHE C,

" basic character operations
syn keyword forthCharOps (.) CHAR EXPECT FIND WORD TYPE -TRAILING EMIT KEY
syn keyword forthCharOps KEY? TIB CR BL COUNT SPACE SPACES
" recognize 'char (' or '[char] (' correctly, so it doesn't
" highlight everything after the paren as a comment till a closing ')'
syn match forthCharOps '\<char\s\S\s'
syn match forthCharOps '\<\[char\]\s\S\s'
syn region forthCharOps start=+."\s+ skip=+\\"+ end=+"+

" char-number conversion
syn keyword forthConversion <<# <# # #> #>> #S (NUMBER) (NUMBER?) CONVERT D>F
syn keyword forthConversion D>S DIGIT DPL F>D HLD HOLD NUMBER S>D SIGN >NUMBER
syn keyword forthConversion F>S S>F HOLDS

" interpreter, wordbook, compiler
syn keyword forthForth (LOCAL) BYE COLD ABORT >BODY >NEXT >LINK CFA >VIEW HERE
syn keyword forthForth PAD WORDS VIEW VIEW> N>LINK NAME> LINK> L>NAME FORGET
syn keyword forthForth BODY> ASSERT( ASSERT0( ASSERT1( ASSERT2( ASSERT3( )
syn keyword forthForth >IN ACCEPT ENVIRONMENT? EVALUATE QUIT SOURCE ACTION-OF
syn keyword forthForth DEFER! DEFER@ PARSE PARSE-NAME REFILL RESTORE-INPUT
syn keyword forthForth SAVE-INPUT SOURCE-ID
syn region forthForth start=+ABORT"\s+ skip=+\\"+ end=+"+

" vocabularies
syn keyword forthVocs ONLY FORTH ALSO ROOT SEAL VOCS ORDER CONTEXT #VOCS
syn keyword forthVocs VOCABULARY DEFINITIONS

" File keywords
syn keyword forthFileMode R/O R/W W/O BIN
syn keyword forthFileWords OPEN-FILE CREATE-FILE CLOSE-FILE DELETE-FILE
syn keyword forthFileWords RENAME-FILE READ-FILE READ-LINE KEY-FILE
syn keyword forthFileWords KEY?-FILE WRITE-FILE WRITE-LINE EMIT-FILE
syn keyword forthFileWords FLUSH-FILE FILE-STATUS FILE-POSITION
syn keyword forthFileWords REPOSITION-FILE FILE-SIZE RESIZE-FILE
syn keyword forthFileWords SLURP-FILE SLURP-FID STDIN STDOUT STDERR
syn keyword forthFileWords INCLUDE-FILE INCLUDED REQUIRED
syn keyword forthBlocks OPEN-BLOCKS USE LOAD --> BLOCK-OFFSET
syn keyword forthBlocks GET-BLOCK-FID BLOCK-POSITION LIST SCR BLOCK
syn keyword forthBlocks BUFER EMPTY-BUFFERS EMPTY-BUFFER UPDATE UPDATED?
syn keyword forthBlocks SAVE-BUFFERS SAVE-BUFFER FLUSH THRU +LOAD +THRU
syn keyword forthBlocks BLOCK-INCLUDED BLK

" numbers
syn keyword forthMath DECIMAL HEX BASE
syn match forthInteger '\<-\=[0-9]\+.\=\>'
syn match forthInteger '\<&-\=[0-9]\+.\=\>'
" recognize hex and binary numbers, the '$' and '%' notation is for gforth
syn match forthInteger '\<\$\x*\x\+\>' " *1* --- dont't mess
syn match forthInteger '\<\x*\d\x*\>'  " *2* --- this order!
syn match forthInteger '\<%[0-1]*[0-1]\+\>'
syn match forthFloat '\<-\=\d*[.]\=\d\+[DdEe]\d\+\>'
syn match forthFloat '\<-\=\d*[.]\=\d\+[DdEe][-+]\d\+\>'

" XXX If you find this overkill you can remove it. this has to come after the
" highlighting for numbers otherwise it has no effect.
syn region forthComment start='0 \[if\]' end='\[endif\]' end='\[then\]' contains=forthTodo

" Strings
syn region forthString start=+\.*\"+ end=+"+ end=+$+
" XXX
syn region forthString start=+s\"+ end=+"+ end=+$+
syn region forthString start=+s\\\"+ end=+"+ end=+$+
syn region forthString start=+c\"+ end=+"+ end=+$+

" Comments
syn match forthComment '\\\s.*$' contains=forthTodo,forthSpaceError
syn region forthComment start='\\S\s' end='.*' contains=forthTodo,forthSpaceError
syn match forthComment '\.(\s[^)]*)' contains=forthTodo,forthSpaceError
syn region forthComment start='\(^\|\s\)\zs(\s' skip='\\)' end=')' contains=forthTodo,forthSpaceError
syn region forthComment start='/\*' end='\*/' contains=forthTodo,forthSpaceError

" Include files
syn match forthInclude '^INCLUDE\s\+\k\+'
syn match forthInclude '^REQUIRE\s\+\k\+'
syn match forthInclude '^FLOAD\s\+'
syn match forthInclude '^NEEDS\s\+'

" Locals definitions
syn region forthLocals start='{\s' start='{$' end='\s}' end='^}'
syn match forthLocals '{ }' " otherwise, at least two spaces between
syn region forthDeprecated start='locals|' end='|'

" Define the default highlighting.
hi def link forthTodo Todo
hi def link forthOperators Operator
hi def link forthMath Number
hi def link forthInteger Number
hi def link forthFloat Float
hi def link forthStack Special
hi def link forthRstack Special
hi def link forthFStack Special
hi def link forthSP Special
hi def link forthMemory Function
hi def link forthAdrArith Function
hi def link forthMemBlks Function
hi def link forthCond Conditional
hi def link forthLoop Repeat
hi def link forthColonDef Define
hi def link forthEndOfColonDef Define
hi def link forthDefine Define
hi def link forthDebug Debug
hi def link forthAssembler Include
hi def link forthCharOps Character
hi def link forthConversion String
hi def link forthForth Statement
hi def link forthVocs Statement
hi def link forthString String
hi def link forthComment Comment
hi def link forthClassDef Define
hi def link forthEndOfClassDef Define
hi def link forthObjectDef Define
hi def link forthEndOfObjectDef Define
hi def link forthInclude Include
hi def link forthLocals Type " nothing else uses type and locals must stand out
hi def link forthDeprecated Error " if you must, change to Type
hi def link forthFileMode Function
hi def link forthFunction Function
hi def link forthFileWords Statement
hi def link forthBlocks Statement
hi def link forthSpaceError Error

let b:current_syntax = "forth"

let &cpo = s:cpo_save
unlet s:cpo_save
" vim:ts=8:sw=4:nocindent:smartindent:
