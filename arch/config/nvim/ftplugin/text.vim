autocmd VimEnter * Limelight
autocmd VimEnter * SoftPencil

nnoremap <buffer> j gj
vnoremap <buffer> j gj
onoremap <buffer> j gj
nnoremap <buffer> k gk
vnoremap <buffer> k gk
onoremap <buffer> k gk
nnoremap <buffer> 0 g0
nnoremap <buffer> $ g$

setlocal scrolloff=999
setlocal wrap
setlocal linebreak
setlocal spell spelllang=en_gb
