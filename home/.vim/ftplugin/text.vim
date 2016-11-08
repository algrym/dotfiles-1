if !&readonly
    setlocal spell
endif

setlocal formatoptions+=n

" Ignore case when <Tab>-completing
setlocal infercase

nnoremap <buffer> <F3> :match Title /^[[:digit:]]\+\..*\_$\(\n.\+\)*\(\n\n\)\@=/<CR>
