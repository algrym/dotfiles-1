function! Get_Markdown_Header_Level(lnum) " {{{
    let l1 = getline(a:lnum)

    if l1 =~ '^\s*$'
        return 0
    endif

    let l2 = getline(a:lnum+1)

    if l1 =~ '^#'
        return matchend(l1, '^#\+')
    elseif  l2 =~ '^==\+\s*'
        return 1
    elseif l2 =~ '^--\+\s*'
        return 2
    endif

    return 0
endfunction " }}}

function! Foldexpr_markdown(lnum) " {{{
    let line = getline(a:lnum)
    let anchor_re = '\v^\<a name.*'

    if line =~ anchor_re
        let next_line_hval = Get_Markdown_Header_Level(a:lnum + 1)
        if next_line_hval
            return '>' . next_line_hval
        else
            return '='
        endif
    endif

    let line_hval = Get_Markdown_Header_Level(a:lnum)

    if line_hval
        if getline(a:lnum - 1) =~ anchor_re
            return line_hval
        else
            return '>' . line_hval
        endif
    elseif a:lnum == 1
        " fold any 'preamble'
        return '>1'
    else
        " keep previous foldlevel
        return '='
    endif
endfunction " }}}

setlocal foldexpr=Foldexpr_markdown(v:lnum)
setlocal foldmethod=expr

setlocal foldenable
setlocal foldlevel=1
setlocal foldcolumn=0

setlocal spell
setlocal wrap
setlocal textwidth=80

setlocal formatoptions+=n

" Use <localleader>1/2 to add headings:
nnoremap <buffer> <localleader>1 yypVr=:redraw<cr>
nnoremap <buffer> <localleader>2 yypVr-:redraw<cr>

" Italic word under cursor
nnoremap <buffer> <localleader>i mzciw**<esc>P`zl

" Bold word under cursor
nnoremap <buffer> <localleader>b mzciw****<esc>hP`zll
