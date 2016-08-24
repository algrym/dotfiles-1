setlocal foldmethod=syntax

" Make (<cr> insert a pair of brackets in such a way that the cursor is correctly
" positioned inside of them AND the following code doesn't get unfolded.
inoremap <buffer> (<cr> ()<left><cr><tab>.<cr><esc>kA<bs>

let g:perl_fold = 1
let g:perl_sync_dist = 250
let perl_string_as_statement = 1
let g:perl_fold_anonymous_subs = 1
let g:perl_nofold_packages = 1
