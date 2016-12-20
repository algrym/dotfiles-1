nnoremap <silent> <buffer> <localleader>i ciW{{i18n ''}}<esc>hhP
nnoremap <silent> <buffer> <localleader>l :put='{{log \"<C-r><C-w>\" <C-r><C-w>}}'<CR>==
nnoremap <silent> <buffer> <localleader>L :setlocal iskeyword+=.<CR>
  \ :put='{{log \"<C-r><C-w>\" <C-r><C-w>}}'
  \ <CR>==:setlocal iskeyword-=.<CR>

