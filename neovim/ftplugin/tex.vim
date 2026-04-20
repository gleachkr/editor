" vim:fdm=marker

" General Settings {{{

if !exists('g:vimtex_fold_enabled')
    let g:vimtex_fold_enabled=1
    "turns it on, unless it's already been turned off by a large file.
endif
" Formatting {{{
setlocal lbr
setlocal sw=2
setlocal tw=80 "turns on wrapping after 80 characters
"}}}
" Spelling {{{
setlocal spell
syntax spell toplevel
"turns on spellchecking outside of the comments
"}}}
" Appearance {{{
setlocal conceallevel=2 "turns on specal-character conceal
ColorScheme zenburn
"}}}
"}}}
" vimtex options {{{
let g:vimtex_view_method='sioyek'

"}}}
"normal mappings{{{

nnoremap <buffer> <leader>ll :VimtexCompile<cr>
nnoremap <buffer> <leader>lv :VimtexView<cr>
nnoremap <buffer> <leader>wc :VimtexCountWords<cr>
"}}}
"insert mappings{{{

imap <buffer>\|\| <plug>(vimtex-delim-close)

"}}}
" Should write a smarter compiler method that checks for a Makefile
"makefile for compiler{{{
" function! Callback(msg)
" Use a regex match on the compiler output to get automatic VimtexErrors
" functionality. The below conditional must likely be changed to be
" useful, of course!
"if a:msg =~# 'error'
"  call vimtex#compiler#callback(!vimtex#qf#inquire(b:vimtex.tex))
"endif
"endfunction

"let g:vimtex_compiler_method = 'generic'
"let g:vimtex_compiler_generic = {
"  \ 'command' : 'make',
"  \ 'hooks': [function('Callback')],
"  \}
""}}}
