setlocal foldmethod=syntax
setlocal textwidth=73 " 80 - 7 columns that IceBreak adds when compiling

" RPG/ILE is in case-sensitive
setlocal tagcase=ignore
setlocal nosmartcase
setlocal ignorecase

setlocal suffixesadd=.rpgle,.rpgleinc,.aspx,.asmx
setlocal include=\\s*/\\s*include
" Hackish way to match pathnames in-case sensitive
setlocal includeexpr=glob(expand('%:p:h').'/'.substitute(v:fname,',','/','g').'.*')

" Match declarations but also things with word word, as it must also be
" declarations inside data structures, procedure interfaces:
" dcl-ds abc;
"   myVar type(1)
"   myVar2 type2;
" end-ds;
setlocal define=^\\s*\\%(dcl-proc\\s\\+\\ze\\w\\+\\\|\\%(dcl-\\%([sc]\\\|ds\\)\\)\\=\\s\\+\\ze\\w\\+\\s\\+\\w\\+\\)

let g:rpgle_fold_enabled = 1
let g:rpgle_fold = 64 + 128 + 256

setlocal shiftwidth=2 softtabstop=2 expandtab

nnoremap <silent> <buffer> <localleader>ts :Tabularize /dcl-\(s\\|c\\|ds\)\s\+\w\+\zs<CR>

setlocal errorformat=%f:%l:\ %m
setlocal makeprg=rpglemake\ %:p
