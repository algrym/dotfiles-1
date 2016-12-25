if !&readonly
    setlocal spell
endif

setlocal formatoptions+=tn

" Ignore case when <Tab>-completing
setlocal infercase

nnoremap <buffer> <F3> :match Constant /^[0-9]\+\.\%(.\+\_$\n\)\+$/<CR>
