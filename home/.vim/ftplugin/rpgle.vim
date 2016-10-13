set foldmethod=syntax foldlevel=0
set textwidth=73 " 80 - 7 columns that icebreak addeds when compiling
let g:rpgle_fold_enabled = 1

setlocal shiftwidth=2 softtabstop=2 expandtab

nnoremap <buffer> <localleader>ts :Tabularize /dcl-s\s\+\w\+\zs<CR>
