if exists('g:loaded_ctrl_yank_register')
	finish
endif
let g:loaded_ctrl_yank_register = 1

let s:yank_register_var = {
			\  'init':   'ctrlp#yank_register#init()',
			\  'exit':   'ctrlp#yank_register#exit()',
			\  'accept': 'ctrlp#yank_register#accept',
			\  'lname':  'yank_register',
			\  'sname':  'yank_register',
			\  'type':   'yank_register',
			\  'sort':   0,
			\}

if exists('g:ctrlp_ext_vars') && !empty(g:ctrlp_ext_vars)
	let g:ctrlp_ext_vars = add(g:ctrlp_ext_vars, s:yank_register_var)
else
	let g:ctrlp_ext_vars = [s:yank_register_var]
endif

function! ctrlp#yank_register#init()
	let s = ''
	redir => s
	silent registers
	redir END
	return split(s, "\n")[1:]
endfunc

function! ctrlp#yank_register#accept(mode, str)
	call ctrlp#exit()
	echom 'yank-reg'
	let reg_char=matchstr(a:str, '^\S\+\ze.*')[1]
	call setreg('+', getreg(reg_char))
	" NOTE: paste now
	" 	exe "normal! ".matchstr(a:str, '^\S\+\ze.*')."p"
endfunction

function! ctrlp#yank_register#exit()
endfunction

let s:id = g:ctrlp_builtins + len(g:ctrlp_ext_vars)
function! ctrlp#yank_register#id()
	return s:id
endfunction
