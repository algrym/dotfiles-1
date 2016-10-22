setlocal foldmethod=syntax
setlocal shiftwidth=2 softtabstop=2 expandtab

let g:perl_fold = 1
let g:perl_sync_dist = 250
let perl_string_as_statement = 1
let g:perl_fold_anonymous_subs = 1
let g:perl_nofold_packages = 1

setlocal errorformat=%f:%l:%c:%m
setlocal makeprg=perlcritic\ --verbose\ 1\ -3\ %
