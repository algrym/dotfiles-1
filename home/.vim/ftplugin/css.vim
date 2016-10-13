setlocal tabstop=4 shiftwidth=4 softtabstop=4

" Sort properties in selector
nnoremap <buffer> <localleader>s ?{<CR>jV/\v^\s*\}?$<CR>k:sort /\v(^\s+-\a+-)?\zs\a+(-\a+)*\ze:/ r<CR>:noh<CR>
