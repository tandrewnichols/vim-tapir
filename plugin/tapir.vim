if exists("g:loaded_tapir") || &cp | finish | endif

let g:loaded_tapir = 1

let g:tapir_VERSION = '1.0.0'

let g:tapir_methods = ['Get', 'Post', 'Put', 'Delete', 'Options', 'Patch']

call vigor#option#set('tapir', {
  \   'default_view': 'e',
  \   'default_protocol': 'http://'
  \ })

for method in g:tapir_methods
  let lower = tolower(method)
  exec "command! -nargs=* -complete=custom,tapir#complete" method "call tapir#request#request(g:tapir_default_view, " . string(lower) . ", <q-args>)"
  exec "command! -nargs=* -complete=custom,tapir#complete E" . method "call tapir#request#request('e', " . string(lower) . ", <q-args>)"
  exec "command! -nargs=* -complete=custom,tapir#complete T" . method "call tapir#request#request('tabnew', " . string(lower) . ", <q-args>)"
  exec "command! -nargs=* -complete=custom,tapir#complete V" . method "call tapir#request#request('vnew', " . string(lower) . ", <q-args>)"
  exec "command! -nargs=* -complete=custom,tapir#complete S" . method "call tapir#request#request('new', " . string(lower) . ", <q-args>)"
endfor
