setlocal foldmethod=syntax

function! s:JQ(...) " {{{1
    let args = []
    let range = '%'
    if a:0 > 0 | let args = a:1 | endif
    if a:0 > 2 | let range=a:2 . ',' . a:3 | endif

    echom range

    if len(filter(args[:], { key, val -> strpart(val, 0, 1) != '-' })) == 0
        call extend(args, ['.'])
    endif

    let l:command = ['jq', '--indent', &shiftwidth]
    if &expandtab == 0
        call extend(l:command, ['--tab'])
    endif

    call extend(l:command, args)
    :execute ':silent ' . range . '!' . join(l:command, ' ')
endfunction

command! -range=% -nargs=* JQ call <SID>JQ([<f-args>], <line1>, <line2>)

" }}}

" Sort and indent
nnoremap <buffer> <localleader>S :call <SID>JQ(['--sort-keys'])<cr>

" Proper indent
nnoremap <buffer> g= :call <SID>JQ()<cr>
