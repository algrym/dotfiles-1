setlocal define=
setlocal suffixesadd+=.js
setlocal include=

setlocal foldmethod=syntax

setlocal noexpandtab
setlocal textwidth=100

let b:match_words = '\<function\>:\<return\>,'
  \ . '\<do\>:\<while\>,'
  \ . '\<switch\>:\<case\>:\<default\>,'
  \ . '\<if\>:\<else\>,'
  \ . '\<try\>:\<catch\>:\<finally\>'

nnoremap <buffer> <localleader>l :put='console.log(\"<C-r><C-w>\", <C-r><C-w>);'<CR>==
nnoremap <buffer> <localleader>L :setlocal iskeyword+=.<CR>:put='console.log(\"<C-r><C-w>\", <C-r><C-w>);'<CR>==:setlocal iskeyword-=.<CR>

nnoremap <buffer> g= ?{<CR>v%:s/\v\s*:\s*/: /<cr>:noh<cr>gv=

setlocal errorformat=%f:%l:%c:\ %m
setlocal makeprg=jscs\ --no-colors\ --max-errors\ -1\ --reporter\ unix\ %

autocmd! BufWritePost <buffer> if line('$') < 1000 | silent make! | silent redraw! | endif
