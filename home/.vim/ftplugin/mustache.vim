nnoremap <buffer> <localleader>i ciW{{i18n ''}}<esc>hhP
nnoremap <buffer> <localleader>l :put='{{log \"<C-r><C-w>\" <C-r><C-w>}}'<CR>==
nnoremap <buffer> <localleader>L :setlocal iskeyword+=.<CR>
  \ :put='{{log \"<C-r><C-w>\" <C-r><C-w>}}'
  \ <CR>==:setlocal iskeyword-=.<CR>

