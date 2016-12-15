setlocal tabstop=2 shiftwidth=2 softtabstop=2
setlocal smartindent
setlocal foldmethod=marker foldmarker={,}

" Sort properties in selector
nnoremap <buffer> <localleader>s :call <SID>ScssExec(['sort', 'sort /\v(^\s+-\a+-)?\zs\a+(-\a+)*\ze:/ r'])<CR>

" Fix color:red -> color: red, and color :red -> color: red
nnoremap <buffer> <localleader>: :call <SID>ScssExec(['s/\a\zs\s*:\s*/: /'])<CR>
nnoremap <buffer> <localleader>{ :keepp s/\a\zs\ze{/ /<CR>

function! s:ScssExec(args)
  for arg in a:args
    execute ':keepp ?{?+1,/^\s*}\=$\|{\s*$/-1:' . arg
  endfor
endfunction

setlocal tags=./html.tags,html.tags,./tags,tags,./js.tags,js.tags

setlocal errorformat=%f:%l:%c\ [E]\ %m
setlocal makeprg=scss-lint\ %
" autocmd! BufWritePost <buffer> silent make! | silent redraw! | silent wincmd p
