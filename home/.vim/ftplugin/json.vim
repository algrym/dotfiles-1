setlocal foldmethod=syntax

nnoremap <buffer> <localleader>S :call <SID>JQ(['--sort-keys', '.'])<cr>

nnoremap <buffer> g= :call <SID>JQ(['.'])<cr>

function! s:JQ(args)
    let l:command = ['jq', '--indent', &shiftwidth]
    if &expandtab == 0
        call extend(l:command, ['--tab'])
    endif
    call extend(l:command, a:args)
    :execute ':silent %!' . join(l:command, ' ')
endfunction
