set noexpandtab
set tabstop=4 shiftwidth=4 softtabstop=4

" Make {<cr> insert a pair of brackets in such a way that the cursor is correctly
" positioned inside of them AND the following code doesn't get unfolded.
inoremap <buffer> {<cr> {}<left><cr><tab>.<cr><esc>kA<bs>

" Sort properties in class
nnoremap <buffer> <localleader>s ?{<CR>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>
