setlocal shiftwidth=4 softtabstop=4 expandtab
setlocal spell

function! Foldexpr_Pod(lev)
    let mytext = getline(a:lev)
    let result="="
    if mytext =~ '^=item'
        let result=">3"
    elseif mytext =~ '^=back'
        let result="<2"
    elseif mytext =~ '^=over'
        let result=">2"
    elseif mytext =~ '^=cut'
        let result="<1"
    elseif mytext =~ '^=\w\+'
        let result='>1'
    endif
    return result
endfunction

setlocal foldexpr=Foldexpr_Pod(v:lnum)
setlocal foldmethod=expr

setlocal foldenable
setlocal foldlevel=0
setlocal foldcolumn=0
