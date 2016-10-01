set foldmethod=syntax foldlevel=0
set textwidth=73 " 80 - 7 columns that icebreak addeds when compiling
let g:rpgle_fold_enabled = 1

nnoremap <buffer> <localleader>ts :Tabularize /dcl-s\s\+\w\+\zs<CR>
