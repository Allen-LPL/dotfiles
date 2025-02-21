" Vim ftplugin file
" Language:	8th
" Version:	any
" Last Change:	2015/11/08
" Maintainer:	Ron Aaron <ron@aaron-tech.com>
" URL:          https://8th-dev.com/
" Filetypes:	*.8th
" NOTE: 	8th allows any non-whitespace in a name, so you need to do:
" 		setlocal iskeyword=!,@,33-35,%,$,38-64,A-Z,91-96,a-z,123-126,128-255
" 		This goes with the syntax/8th.vim file.

" Only do this when not done yet for this buffer
if exists("b:did_8thplugin")
 finish
endif

" Don't load another plugin for this buffer
let b:did_8thplugin = 1

setlocal ts=2 sts=2 sw=2 et
setlocal com=s1:/*,mb:*,ex:*/,:\|,:\\
setlocal fo=tcrqol
setlocal matchpairs+=\::;
setlocal iskeyword=!,@,33-35,%,$,38-64,A-Z,91-96,a-z,123-126,128-255
setlocal suffixesadd=.8th
