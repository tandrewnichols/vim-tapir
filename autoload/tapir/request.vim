function! tapir#request#request(cmd, method, ...) abort
  let request = a:0 ? tapir#request#parseArgs(a:method, a:1) : {}
  call extend(request, { 'cmd': a:cmd, 'method': a:method })
  call tapir#request#send(request)
endfunction

function! tapir#request#parseArgs(method, args) abort
  let args = a:args
  let headers = {}
  let data = {}

  let contenttype = matchstr(args, '\zs\(text\|application\|image\|video\|multipart\|audio\)\/[^ ]\+\ze')
  if !empty(contenttype)
    let args = substitute(args, contenttype, '', '')
    let headers[ 'Content-Type' ] = contenttype
  endif
  
  let cookies = vigor#string#matchAll(args, ' \zs[^=]\+=[^;]\+;\ze \?')

  if !empty(cookies)
    for cookie in cookies
      let args = substitute(args, cookie, '', '')
    endfor

    let headers.Cookie = join(cookies, ' ')
  endif

  let otherheaders = vigor#string#matchAll(args, ' \zs[a-zA-Z-]\+:[^ ]\+\ze')

  if !empty(otherheaders)
    for header in otherheaders
      let args = substitute(args, header, '', '')
      let [ field, value ] = split(header, ':')
      let headers[ field ] = value
    endfor
  endif

  return { 'headers': headers, 'url': args }
endfunction

function! tapir#request#send(request) abort
  let url = a:request.url
  let method = a:request.method
  let headers = a:request.headers

  let cmd = 'curl -X ' . toupper(method)

  if !empty(headers)
    for header in items(headers)
      let cmd .= ' -H "' . join(header, ': ') . '"'
    endfor
  endif

  let cmd .= ' -s -i ' . (match(url, '^http') ? url : g:tapir_default_protocol . url)

  exec "silent let lines = systemlist(" . string(cmd) . ")"

  let brk = vigor#list#findIndex(lines, 'tapir#request#isEmpty', 1)
  let response = {
    \   'headers': lines[0:brk - 1],
    \   'text': lines[brk + 1:]
    \ }

  call tapir#request#open(a:request, response)
endfunction

function! tapir#request#isEmpty(line) abort
  return trim(a:line) == ''
endfunction

function! tapir#request#open(request, response) abort
  call tapir#request#content(a:request, a:response)
  call tapir#request#headers(a:request, a:response)
  wincmd p
endfunction

function! tapir#request#content(request, response) abort
  let request = a:request
  let response = a:response

  exec request.cmd toupper(request.method) . "\ " . request.url

  let text = join(response.text, "\r")
  let headers = join(response.headers, "\r")

  if text =~? 'doctype html'
    setlocal ft=html
  elseif headers =~? 'Content-Type: application/json'
    let text = systemlist('node -e "console.log(JSON.stringify(JSON.parse(process.argv[1]), null, 2))" ' . string(text))
    setlocal ft=json
  endif

  call setline(1, text)
  silent! %s/\r//
  
  call tapir#request#configure()
endfunction

function! tapir#request#headers(request, response) abort
  exec "abo" len(a:response.headers) . "new [HEADERS]"
  call setline(1, a:response.headers)
  silent! %s/\r//
  setlocal ft=tapir
  call tapir#request#configure()
endfunction

function! tapir#request#configure() abort
  setlocal foldcolumn=0
  setlocal nofoldenable
  setlocal nospell
  setlocal nobuflisted
  setlocal buftype=nofile
  setlocal nomodifiable
  setlocal noswapfile
  setlocal nowrap
endfunction
