setlocal foldmethod=syntax
setlocal textwidth=73 " 80 - 7 columns that IceBreak adds when compiling

" RPG/ILE is in case-sensitive
setlocal tagcase=ignore
setlocal nosmartcase
setlocal ignorecase


setlocal suffixesadd=.aspx,.asmx,.mbr
setlocal include=\\s*/\\s*include
setlocal includeexpr=substitute(v:fname,',','/','g')

let g:rpgle_fold_enabled = 1
let g:rpgle_fold = 64 + 128 + 256

setlocal shiftwidth=2 softtabstop=2 expandtab

nnoremap <buffer> <localleader>ts :Tabularize /dcl-\(s\\|c\\|ds\)\s\+\w\+\zs<CR>

setlocal errorformat=%f:%l:\ %m
setlocal makeprg=rpglemake\ %:p
