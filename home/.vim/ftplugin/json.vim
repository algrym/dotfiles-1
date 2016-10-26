setlocal expandtab shiftwidth=2 softtabstop=2
setlocal foldmethod=syntax

" Sort and indent
nnoremap <buffer> <localleader>s :%!jq --indent 2 .<CR>
nnoremap <buffer> <localleader>S :%!jq --sort-keys --indent 2 .<CR>
