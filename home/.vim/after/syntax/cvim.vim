" Enable shell syntax inside code blocks
if exists("b:current_syntax")
  unlet b:current_syntax
endif
syn include @shCode syntax/sh.vim
syn region codeBlock start=/^    \|\t/ end=/$/ contains=@shCode
