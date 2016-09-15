setlocal foldmethod=syntax
setlocal sw=2 ts=2 expandtab
let g:sh_fold_enabled = 7

setlocal makeprg=shellcheck\ -x\ -f\ gcc\ %
autocmd! BufWritePost <buffer> silent make! | silent redraw! | silent wincmd p
