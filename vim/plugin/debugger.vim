pyfile ~/.vim/plugin/debugger.py
map <leader><F1> :python debugger_resize()<cr>
map <leader><F2> :python debugger_command('step_into')<cr>
map <leader><F3> :python debugger_command('step_over')<cr>
map <leader><F4> :python debugger_command('step_out')<cr>

nnoremap ,e :python debugger_watch_input("eval")<cr>A
"nnoremap E :python debugger_watch_input("exec")<cr>A

map <leader><F5> :python debugger_run()<cr>
map <leader><F6> :python debugger_quit()<cr>

"map <leader><F7> :echo 'not yet'
"map <leader><F8> :python debugger.ui.watchwin.clean()<cr>:python debugger.ui.watchwin.write('<?')<cr>:python debugger.ui.logwin.clean()<cr>
"map <leader><F9> :echo 'not yet'

map <leader><F11> :python debugger_context()<cr>
map <leader><F12> :python debugger_property()<cr>
map <leader><F11> :python debugger_watch_input("context_get")<cr>A<cr>
map <leader><F12> :python debugger_watch_input("property_get", '<cword>')<cr>A<cr>

hi DbgCurrent term=reverse ctermfg=White ctermbg=Red gui=reverse
hi DbgBreakPt term=reverse ctermfg=White ctermbg=Green gui=reverse

command! -nargs=? Bp python debugger_mark('<args>')
command! -nargs=0 Up python debugger_up()
command! -nargs=0 Dn python debugger_down()
sign define current text=->  texthl=DbgCurrent linehl=DbgCurrent
sign define breakpt text=B>  texthl=DbgBreakPt linehl=DbgBreakPt
python debugger_init(9000, 1)

