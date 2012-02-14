" Vim compiler file
" Compiler:	    PHPUnit
" Maintainer:	Ben Godfrey <ben@ben2.com>
" URL:		    https://github.com/afternoon/vim-phpunit
" Last Change:	2011 Mar 9

if exists("current_compiler")
  finish
endif
let current_compiler = "phpunit"

if exists(":CompilerSet") != 2		" older Vim always used :setlocal
  command -nargs=* CompilerSet setlocal <args>
endif

CompilerSet makeprg=phpunit\ $*

CompilerSet errorformat=%E%n)\ %.%#,%Z%f:%l,%C%m,%-G%.%#
