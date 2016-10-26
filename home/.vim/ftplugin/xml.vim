setlocal expandtab shiftwidth=4 softtabstop=4
setlocal foldmethod=syntax

" Auto insert closing tags
inoremap <buffer> </ </<C-x><C-o>
nnoremap <buffer> <localleader>s :%!xmllint --format -<CR>
