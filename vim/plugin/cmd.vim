"cmd.vim: collection of shell commands in vim version 
"Author: ypguo<guoyoooping@163.com>
"Date: 2010.4.2
"Base version: 1.0

com! -nargs=* -range=0 -complete=file Shell call Cmd_Shell(<q-args>)
com! -nargs=* -range=0 -complete=file Cmd call Cmd_Shell(<q-args>)

"Build-in functions
com! -nargs=0 Date call Cmd_Shell("date", <q-args>)
com! -nargs=0 Ls call Cmd_Shell("ls", <q-args>)
com! -nargs=* Gcc call Cmd_Shell("gcc", expand("%"), <q-args>)

"Need install by yourself
com! -nargs=* -range=0 -complete=file Sdcv call Cmd_Shell("sdcv", <q-args>)

function Cmd_Shell(...)
	let Cmd_Cmd = ''
	for s in a:000
		let Cmd_Cmd .= s . ' '
	endfor
	echo Cmd_Cmd
	let Cmd_Output = system(Cmd_Cmd)
	"let Cmd_Output = iconv(Cmd_Output, "utf8", "cp936")
	echo Cmd_Output
endfunction

