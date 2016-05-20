" TODO Implement a map to copy path to JSON

set foldmethod=syntax

" Make {<cr> insert a pair of brackets in such a way that the cursor is correctly
" positioned inside of them AND the following code doesn't get unfolded.
inoremap <buffer> {<cr> {}<left><cr><tab>.<cr><esc>kA<bs>

" Make [<cr> insert a pair of brackets in such a way that the cursor is correctly
" positioned inside of them AND the following code doesn't get unfolded.
inoremap <buffer> [<cr> []<left><cr><tab>.<cr><esc>kA<bs>
