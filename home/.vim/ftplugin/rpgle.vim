setlocal foldmethod=syntax
setlocal textwidth=73 " 80 - 7 columns that icebreak addeds when compiling
setlocal tagcase=ignore

setlocal suffixesadd=.aspx,.asmx
setlocal include=\\s*/\\s*include

let g:rpgle_fold_enabled = 1
let g:rpgle_fold = 64 + 128 + 256

setlocal shiftwidth=2 softtabstop=2 expandtab

nnoremap <buffer> <localleader>ts :Tabularize /dcl-s\s\+\w\+\zs<CR>
