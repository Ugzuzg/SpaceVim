"=============================================================================
" racket.vim --- racket language support in spacevim
" Copyright (c) 2016-2019 Wang Shidong & Contributors
" Author: Wang Shidong < wsdjeg at 163.com >
" URL: https://spacevim.org
" License: GPLv3
"=============================================================================

function! SpaceVim#layers#lang#racket#plugins() abort
  let plugins = []
  call add(plugins, ['wlangstroth/vim-racket', {'merged' : 0}])
  return plugins
endfunction


function! SpaceVim#layers#lang#racket#config() abort
  augroup spacevim_layer_lang_racket
    autocmd!
    au BufRead,BufNewFile *.rkt,*.rktl setf racket
  augroup END
  call SpaceVim#plugins#runner#reg_runner('racket', 
        \ {
        \ 'exe' : 'racket',
        \ 'opt' : ['-f'],
        \ 'usestdin' : 0,
        \ })
  call SpaceVim#mapping#gd#add('racket', function('s:go_to_def'))
  call SpaceVim#plugins#repl#reg('racket', ['racket', '-i'])
  call SpaceVim#mapping#space#regesit_lang_mappings('racket', function('s:language_specified_mappings'))
endfunction

function! s:go_to_def() abort

endfunction

function! s:language_specified_mappings() abort
  call SpaceVim#mapping#space#langSPC('nmap', ['l','r'],
        \ 'call SpaceVim#plugins#runner#open()',
        \ 'execute current file', 1)
  " nnoremap <silent><buffer> K :call SpaceVim#lsp#show_doc()<CR>
  let g:_spacevim_mappings_space.l.s = {'name' : '+Send'}
  call SpaceVim#mapping#space#langSPC('nmap', ['l','s', 'i'],
        \ 'call SpaceVim#plugins#repl#start("racket")',
        \ 'start REPL process', 1)
  call SpaceVim#mapping#space#langSPC('nmap', ['l','s', 'l'],
        \ 'call SpaceVim#plugins#repl#send("line")',
        \ 'send line and keep code buffer focused', 1)
  call SpaceVim#mapping#space#langSPC('nmap', ['l','s', 'b'],
        \ 'call SpaceVim#plugins#repl#send("buffer")',
        \ 'send buffer and keep code buffer focused', 1)
  call SpaceVim#mapping#space#langSPC('nmap', ['l','s', 's'],
        \ 'call SpaceVim#plugins#repl#send("selection")',
        \ 'send selection and keep code buffer focused', 1)
endfunction