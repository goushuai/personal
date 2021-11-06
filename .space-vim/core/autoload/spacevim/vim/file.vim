function! s:buf_total_num()
  return len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))
endfunction

function! s:file_size(f)
  let l:size = getfsize(expand(a:f))
  if l:size == 0 || l:size == -1 || l:size == -2
    return ''
  endif
  if l:size < 1024
    return l:size.'bytes'
  elseif l:size < 1024*1024
    return printf('%.1f', l:size/1024.0).'K'
  elseif l:size < 1024*1024*1024
    return printf('%.1f', l:size/1024.0/1024.0) . 'M'
  else
    return printf('%.1f', l:size/1024.0/1024.0/1024.0) . 'G'
  endif
endfunction

function! spacevim#vim#file#CtrlG() abort
  redir => file
  :silent f!
  redir END
  let l:msg = join([file[2:], 'Cursor line:'.line('.').',col:'.col('.'), s:file_size(@%), 'TOT:'.s:buf_total_num(), '['.&filetype.']'], ' ')
  call spacevim#vim#cursor#TruncatedEcho(l:msg)
endfunction
