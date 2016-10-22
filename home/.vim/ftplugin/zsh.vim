setlocal shiftwidth=2 softtabstop=2 expandtab
setlocal foldmethod=syntax

" Don't break commands with a newline as it wont work, would be nice if it could
" insert a backslash infront. But not break strings, i.e:
" ##############################################
" | curl -trace-ascii my_trace.txt --b \       |
" | my_cookie.jar \                            |
" | "This string should not be broken, as it's a string" \
" | -- https://example.com                     |
" | ~                                          |
" | ~                                          |
" | ~                                          |
" | ~                                          |
" | ~                                          |
" | ~                                          |
" ##############################################
setlocal formatoptions-=t
