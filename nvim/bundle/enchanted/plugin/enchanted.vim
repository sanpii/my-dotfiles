" Author: Marcin Szamotulski
" Email:  mszamot [AT] gmail [DOT] com
" License: vim-license, see :help license

" This is a tiny vim script which makes searches with \v persistent.
" You can turn it off temporarily with 
"   let g:VeryMagic = 0
" or if you are already in the command line you can type \m or \M (see :help
" \m).
" HowItWorks: it simply injects \v at the beginning of your pattern after you
" press enter.
" Note: if you are using one of the two other of my plugins which are defining
" maps to <CR> in the command line, you need to update them to the latest
" version so that they will all work:
"   system : http://www.vim.org/scripts/script.php?script_id=4224
"   CommandAlias : http://www.vim.org/scripts/script.php?script_id=4250

let g:VeryMagic = 1

if !exists('CRDispatcher')
    let g:CRDispatcher = {}
    fun g:CRDispatcher.dispatch() dict
	let cmdtype = getcmdtype()
	if cmdtype == ':'
	   if has_key(self, 'expr')
	       return self.expr()
	   endif
	elseif cmdtype == '/'
	    if has_key(self, 'search')
		return self.search()
	    endif
	endif
	return getcmdline()
    endfun
endif
if !exists('*CRDispatch')
    fun CRDispatch()
	return g:CRDispatcher.dispatch()
    endfun
endif

fun! g:CRDispatcher.search() dict
    let cmdline = getcmdline()
    if g:VeryMagic && cmdline !~# '^\\v'
	return '\v'.getcmdline()
    else
	return getcmdline()
    endif
endfun

cno <C-M> <CR>
if empty(maparg('<Plug>CRDispatch', 'c'))
    cno <Plug>CRDispatch <C-\>eCRDispatch()<CR><CR>
endif
cm <CR> <Plug>CRDispatch
