" makeprg is set by ftplugin/javascript.vim
let &makeprg = 'widgetcs ' . &makeprg

nnoremap <buffer> <localleader>s :%!widgetcs jscs -x<CR>
