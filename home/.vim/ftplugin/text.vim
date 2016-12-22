if !&readonly
    setlocal spell
endif

setlocal formatoptions+=tn


" Ignore case when <Tab>-completing
setlocal infercase

nnoremap <buffer> <F3> :match Constant /^[[:digit:]]\+\..*\_$\(\n.\+\)*\(\n\n\)\@=/<CR>
