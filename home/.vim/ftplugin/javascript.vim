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

nnoremap <buffer> <localleader>l :put='console.log(\"<C-r><C-w>\",
  \ window.<C-r><C-w> = <C-r><C-w>);'<CR>==
nnoremap <buffer> <localleader>L :setlocal iskeyword+=.<CR>
  \ :put='console.log(\"<C-r><C-w>\", <C-r><C-w>);'
  \ <CR>==:setlocal iskeyword-=.<CR>

nnoremap <buffer> <localleader>d odebugger;<ESC>
nnoremap <buffer> <localleader>D Odebugger;<ESC>

nnoremap <buffer> g= ?{<CR>v%:s/\v\s*:\s*/: /<cr>:noh<cr>gv=

setlocal errorformat=%f:%l:%c:\ %m
setlocal makeprg=jscs\ --no-colors\ --max-errors\ -1\ --reporter\ unix\ %

nnoremap <buffer> <localleader>s mz:%!jscs -x<CR>`z

setlocal tags=./js.tags,js.tags,./tags,tags,./html.tags,html.tags

" Somewhat proper section jumping {{{

function! s:NextSection(type, backwards)
  if a:type == 1
    let pattern = '^\%(\t\t\| \{8}\)\w\+\s*:\s*function'
  elseif a:type == 2
    let pattern = '^\%(\t\t\| \{8\}\)}'
  endif

  if a:backwards
    let dir = '?'
  else
    let dir = '/'
  endif

  " Todo shouldn't /pattern/W disable wrapscan?
  let ws = &wrapscan
  let pos = getpos('.')
  setlocal nowrapscan
  execute 'silent! :keepp normal! ' . dir . pattern . dir . 'e' . "\r"
  let &wrapscan = ws

  if pos == getpos('.')
    if a:backwards
      normal! gg
    else
      normal! G
    endif
  endif

endfunction

noremap <script> <buffer> <silent> gd :execute 'keepj normal [[/\<<C-r><C-w>\>/' . "\r"<CR>

noremap <script> <buffer> <silent> ]] :call <SID>NextSection(1, 0)<CR>
noremap <script> <buffer> <silent> ][ :call <SID>NextSection(2, 0)<CR>
noremap <script> <buffer> <silent> [[ :call <SID>NextSection(1, 1)<CR>
noremap <script> <buffer> <silent> [] :call <SID>NextSection(2, 1)<CR>

" }}}
