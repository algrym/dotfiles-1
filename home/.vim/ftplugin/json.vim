setlocal expandtab shiftwidth=2 softtabstop=2
setlocal foldmethod=syntax

function! s:JQ(...) range " {{{1
    let args = []
    if a:0 > 0 | let args = a:1 | endif

    if len(filter(args[:], { key, val -> strpart(val, 0, 1) != '-' })) == 0
        call add(args, '.')
    endif

    let l:command = ['jq', '--indent', &shiftwidth]
    if &expandtab == 0
        call add(l:command, '--tab')
    endif

    call extend(l:command, args)
    execute ':silent ' . a:firstline . ',' . a:lastline . '!' . join(l:command, ' ')
endfunction

command! -range=% -nargs=* JQ <line1>,<line2>call <SID>JQ([<f-args>])

" }}}

" Sort and indent
nnoremap <buffer> <localleader>S :%call <SID>JQ(['--sort-keys'])<cr>

" Proper indent
nnoremap <buffer> g= :call <SID>JQ()<cr>
