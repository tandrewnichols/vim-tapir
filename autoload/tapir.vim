let s:vars = {}
let s:envs = {}

function! tapir#var(name, value) abort
  let s:vars[ a:name ] = value
endfunction

function! tapir#env(env, ...) abort
  if !has_key(s:envs, a:env)
    let s:envs[ a:env ] = {}
  endif

  if a:0 == 1
    call extend(s:envs[ a:env ], a:1)
  elseif a:0 == 2
    let s:envs[ a:env ][ a:1 ] = a:2
  endif
endfunction

function! tapir#complete(lead) abort
  let entries = keys(s:urls)
  return join(entries, "\n")
endfunction
