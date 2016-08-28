setlocal foldmethod=syntax

" Make [<cr> insert a pair of brackets in such a way that the cursor is correctly
" positioned inside of them AND the following code doesn't get unfolded.
inoremap <buffer> [<cr> []<left><cr><tab>.<cr><esc>kA<bs>

let b:match_words = '\<function\>:\<return\>,'
  \ . '\<do\>:\<while\>,'
  \ . '\<switch\>:\<case\>:\<default\>,'
  \ . '\<if\>:\<else\>,'
  \ . '\<try\>:\<catch\>:\<finally\>'

nnoremap <buffer> <localleader>l :put='console.log(\"<C-r><C-w>\", <C-r><C-w>);'<CR>==

nnoremap <buffer> g= ?{<CR>v%:s/\v\s*:\s*/: /<cr>:noh<cr>gv=
