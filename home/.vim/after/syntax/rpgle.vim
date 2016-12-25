" IceBreak Rpgle parser translates %>string constant<% to
" responseWrite('string constant');

sy region ibMultiLine matchgroup=Label start=/`/ skip=/``/ end=/`/

sy region ibRespWrite matchgroup=Label start=/%>/ end=/<%/
sy match  rpgleComment /^[[:space:]]*\*.*/ contains=rpgleTodo
sy cluster rpgleNest add=ibRespWrite,ibMultiLine

hi link ibRespWrite String
hi link ibMultiLine String
