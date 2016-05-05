setlocal foldmethod=syntax
setlocal sw=2 ts=2 expandtab

" Make {<cr> insert a pair of brackets in such a way that the cursor is correctly
" positioned inside of them AND the following code doesn't get unfolded.
inoremap <buffer> {<cr> {}<left><cr><tab>.<cr><esc>kA<bs>

