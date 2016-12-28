" IceBreak Rpgle parser translates %>string constant<% to
" responseWrite('string constant');

sy region ibTpl matchgroup=Label start=/`/ skip=/``/ end=/`/ contains=ibTplExpression

sy region ibTplExpression matchgroup=Label start=/${/ skip=/}}/ end=/}/ contains=@rpgleNest

sy region ibRespWrite matchgroup=Label start=/%>/ end=/<%/
sy match  rpgleComment /^[[:space:]]*\*.*/ contains=rpgleTodo
sy cluster rpgleNest add=ibRespWrite,ibTpl

hi link ibRespWrite String
hi link ibTpl String
