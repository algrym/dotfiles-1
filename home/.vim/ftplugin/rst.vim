setlocal spell
setlocal wrap

setlocal shiftwidth=4 softtabstop=4 expandtab

" Use <localleader>1/2 to add headings:
nnoremap <buffer> <localleader>1 yypVr=:redraw<cr>
nnoremap <buffer> <localleader>2 yypVr-:redraw<cr>

" Italic word under cursor
nnoremap <buffer> <localleader>i mzciw**<esc>P`zl

" Bold word under cursor
nnoremap <buffer> <localleader>b mzciw****<esc>hP`zll
