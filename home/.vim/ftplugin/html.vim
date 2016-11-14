setlocal expandtab shiftwidth=4 softtabstop=4
setlocal foldmethod=syntax
setlocal iskeyword+=-

" Auto insert closing tags
inoremap <buffer> </ </<C-x><C-o>

setlocal tags=./html.tags,html.tags,./tags,tags,./js.tags,js.tags
