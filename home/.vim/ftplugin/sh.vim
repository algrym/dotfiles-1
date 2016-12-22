setlocal shiftwidth=2 softtabstop=2 expandtab
setlocal foldmethod=syntax
let g:sh_fold_enabled = 7

set include=^\\s*\\%(\\.\\\|source\\)\ \\ze\\f\\+
set define=^\\s*\\ze\\w\\+=\\\|\\\<read\ \\%(-r\ \\)\\=

setlocal includeexpr=substitute(v:fname,'\\$\\w\\+\\>\\(.\\)/\\=','\\1','g')

" This makes sure that shell scripts are highlighted as bash scripts
let g:is_posix = 1

" Don't break commands with a newline as it wont work, would be nice if it could
" insert a backslash infront. But not break strings, i.e:
"     +--------------------------------------------+
"     | curl -trace-ascii my_trace.txt --b \       |
"     | my_cookie.jar \                            |
"     | "This string should not be broken, as it's a string" \
"     | -- https://example.com                     |
"     | ~                                          |
"     | ~                                          |
"     | ~                                          |
"     | ~                                          |
"     | ~                                          |
"     | ~                                          |
"     +--------------------------------------------+

setlocal makeprg=shellcheck\ -x\ -f\ gcc\ %
autocmd! BufWritePost <buffer> silent make! | silent redraw! | silent wincmd p
