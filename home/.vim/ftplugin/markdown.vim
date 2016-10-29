setlocal shiftwidth=4 softtabstop=4 expandtab

function! s:Foldexpr(lnum)

endfunction

setlocal foldexpr=<SID>Foldexpr(v:lnum)
setlocal foldmethod=expr

setlocal foldenable

setlocal spell
setlocal wrap
setlocal textwidth=80

setlocal formatoptions+=n

" Use <localleader>1/2 to add headings:
nnoremap <buffer> <localleader>1 yypVr=:redraw<cr>
nnoremap <buffer> <localleader>2 yypVr-:redraw<cr>

" Italic word under cursor
nnoremap <buffer> <localleader>i mzciw**<esc>P`zl

" Bold word under cursor
nnoremap <buffer> <localleader>b mzciw****<esc>hP`zll
