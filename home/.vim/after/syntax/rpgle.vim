" IceBreak Rpgle parser translates %>string constant<% to
" responseWrite('string constant');
sy region ibRespWrite matchgroup=Label start=/%>/ end=/<%/
sy cluster rpgleNest add=ibRespWrite
hi link ibRespWrite String
