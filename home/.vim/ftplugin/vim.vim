setlocal foldmethod=marker
setlocal foldmarker={{{,}}}

function! VimHelp()
  let l:word = expand("<cword>")
  execute ':help ' . l:word
endfunction

nnoremap M :call VimHelp()<cr>
