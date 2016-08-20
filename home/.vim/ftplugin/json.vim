" TODO Implement a map to copy path to JSON

setlocal foldmethod=syntax

" Make [<cr> insert a pair of brackets in such a way that the cursor is correctly
" positioned inside of them AND the following code doesn't get unfolded.
inoremap <buffer> [<cr> []<left><cr><tab>.<cr><esc>kA<bs>

nnoremap <buffer> <localleader>S :call <SID>JQ(['--sort-keys', '.'])<cr>

nnoremap <buffer> <localleader>b :call <SID>JQ(['.'])<cr>

function! s:JQ(args)
    let l:command = ['jq', '--indent', &shiftwidth]
    if &expandtab == 0
        call extend(l:command, ['--tab'])
    endif
    call extend(l:command, a:args)
    :execute ':silent %!' . join(l:command, ' ')
endfunction
