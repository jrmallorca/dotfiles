setlocal tabstop=2 " Show existing tab with 2 spaces width
setlocal shiftwidth=2 " When indenting with '>', use 2 spaces width

let g:dart_style_guide = 2 " 2 space indentation
let g:dart_format_on_save = 1 " DartFmt on buffer save

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Flutter commands
""""""""""""""""""""""""""""""""""""""""""""""""""""""

nnoremap <leader>fa :FlutterRun<cr>
nnoremap <leader>fq :FlutterQuit<cr>
nnoremap <leader>fr :FlutterHotReload<cr>
nnoremap <leader>fR :FlutterHotRestart<cr>
nnoremap <leader>fD :FlutterVisualDebug<cr>
