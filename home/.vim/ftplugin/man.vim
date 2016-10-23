setlocal tabstop=8 shiftwidth=8
setlocal textwidth=0
setlocal foldlevel=10
setlocal nomodified nomodifiable
setlocal nolist nonumber norelativenumber

function! Foldexpr_man(lnum)
  let line = getline(a:lnum + 1)

  return line =~ '^\s\|^$' ? 1 : 0
endfunction

setlocal foldexpr=Foldexpr_man(v:lnum)
setlocal foldmethod=expr
