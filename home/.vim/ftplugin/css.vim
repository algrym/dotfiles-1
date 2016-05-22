set noexpandtab
set tabstop=4 shiftwidth=4 softtabstop=4

" Sort properties in selector
nnoremap <buffer> <localleader>s ?{<CR>jV/\v^\s*\}?$<CR>k:sort<CR>:noh<CR>
