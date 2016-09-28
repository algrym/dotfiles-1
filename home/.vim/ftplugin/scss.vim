setlocal noexpandtab tabstop=2 shiftwidth=2 softtabstop=2

" Sort properties in selector
nnoremap <buffer> <localleader>s ?{<CR>jV/\v^\s*\}?$<CR>k:sort<cr>gv:sort /\v(^\s+-\a+-)?\zs\a+(-\a+)*\ze:/ r<CR>:noh<CR>

setlocal errorformat=%f:%l\ [E]\ %m
setlocal makeprg=scss-lint\ %
autocmd! BufWritePost <buffer> silent make! | silent redraw! | silent wincmd p
