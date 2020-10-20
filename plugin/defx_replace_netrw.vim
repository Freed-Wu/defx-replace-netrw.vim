if exists('g:loaded_defx_replace_netrw') || &cpoptions
	finish
endif
let g:loaded_defx_replace_netrw = 1

let s:save_cpoptions = &cpoptions
set cpoptions&vim

augroup defx_replace_netrw "{{{
	autocmd!
	autocmd VimEnter * autocmd! FileExplorer *
	autocmd BufEnter * ++nested call s:defx(expand('<amatch>'))
augroup END "}}}

function! s:defx(dir) abort "{{{
	if isdirectory(a:dir)
		if get(g:, 'defx_replace_netrw#split', 1) && v:vim_did_enter
			close
		endif
		execute 'bdelete' fnameescape(a:dir)
		if exists(':Defx') == 2
			execute 'Defx' fnameescape(a:dir)
		else
			echohl WarningMsg
			echo 'Please install defx firstly!'
			echohl None
			finish
		endif
	endif
endfunction "}}}

let &cpoptions = s:save_cpoptions
unlet s:save_cpoptions
