setlocal define=
setlocal suffixesadd+=.js

setlocal define=^\\s*\\%(var\\s\\+\\)\\=\\ze\\w\\+\\s*[:=]\\s*function
setlocal include=^\\s*\\%(var\\s\\+\\w\\+\\s*=\\s*\\)\\=require(

setlocal includeexpr=findfile(v:fname)
setlocal smartindent

setlocal foldmethod=syntax

setlocal tabstop=2 shiftwidth=2 softtabstop=2
setlocal textwidth=100

let b:match_words = '\<function\>:\<return\>,'
  \ . '\<do\>:\<while\>,'
  \ . '\<switch\>:\<case\>:\<default\>,'
  \ . '\<if\>:\<else\>,'
  \ . '\<try\>:\<catch\>:\<finally\>'

nnoremap <silent> <buffer> <localleader>l :put='console.log(\"<C-r><C-w>\",
  \ ' . (getline('1') !~# '\<node\>' ? 'window.$<C-r><C-w> = ' : '') .
  \ '<C-r><C-w>);'<CR>==
nnoremap <silent> <buffer> <localleader>L :setlocal iskeyword+=.<CR>
  \ :put='console.log(\"<C-r><C-w>\", <C-r><C-w>);'
  \ <CR>==:setlocal iskeyword-=.<CR>

nnoremap <silent> <buffer> <localleader>d odebugger;<ESC>
nnoremap <silent> <buffer> <localleader>D Odebugger;<ESC>

nnoremap <silent> <buffer> g= ?{<CR>v%:s/\v\s*:\s*/: /<cr>:noh<cr>gv=

setlocal errorformat=%f:%l:%c:\ %m
setlocal makeprg=jscs\ --no-colors\ --max-errors\ -1\ --reporter\ unix\ %

nnoremap <buffer> <localleader>s mz:%!jscs -x<CR>`z

setlocal tags=./js.tags,js.tags,./tags,tags,./html.tags,html.tags

" Somewhat proper section jumping {{{

" Little better section jumping {{{

function! <SID>NextSection(pattern, flags) range

  let cnt = v:count1
  let pos = getpos('.')

  normal! 0
  mark '

  while cnt > 0
    call search(a:pattern, a:flags . 'W')
    normal! ^

    if pos == getpos('.')
      execute 'norm! ' a:flags =~# 'b' ? 'gg' : 'G'
      break
    endif

    let cnt = cnt - 1
  endwhile

endfunction

noremap <script> <buffer> <silent> gd :execute 'keepj normal [[/\<<C-r><C-w>\>/' . "\r"<CR>

noremap <script> <buffer> <silent> ]] :call <SID>NextSection('^\ze\%({\\|\%(var\s\+\w\+\s*=\s*\)\=function.*{\)', '')<CR>
noremap <script> <buffer> <silent> ][ :call <SID>NextSection('^}', '')<CR>
noremap <script> <buffer> <silent> [[ :call <SID>NextSection('^\ze\%({\\|\%(var\s\+\w\+\s*=\s*\)\=function.*{\)', 'b')<CR>
noremap <script> <buffer> <silent> [] :call <SID>NextSection('^}', 'b')<CR>

" }}}
