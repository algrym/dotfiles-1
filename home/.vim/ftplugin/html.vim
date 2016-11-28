setlocal expandtab shiftwidth=4 softtabstop=4
setlocal foldmethod=syntax

nnoremap <C-]> :setlocal iskeyword+=-<CR>viw<ESC>:setlocal iskeyword-=-<CR>gv<C-]>

" Auto insert closing tags
inoremap <buffer> </ </<C-x><C-o>

setlocal tags=./html.tags,html.tags,./tags,tags,./js.tags,js.tags
