""""""""""""""""""""""""""""""""""""""""""""""""""""""
" General
""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Opening new file when current buffer has unsaved changes causes
" files to be hidden instead of closed
" (COC) TextEdit might fail if hidden is not set.
set hidden

" (COC) Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
" Must be either yes or number
" set signcolumn=number
set signcolumn=yes

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=200

let g:python3_host_prog=expand('/usr/bin/python') " Set python3 path
" imap kj <Esc> " Remap Esc to kj
set pastetoggle=<F2> " Toggling pasting to not lose formatting
set number " Show line numbers (Shows current line when paired with relativenumber)
set relativenumber " Show relative line numbers
set smartcase " Smart case
set hlsearch " Searches highlighted
set incsearch " Incremental search
set clipboard=unnamedplus " Set yank to system clipboard
set nowrap " Doesn't wrap lines
filetype indent on " Tab spacing
set tabstop=4 " Show existing tab with 4 spaces width
set shiftwidth=4 " When indenting with '>', use 4 spaces width
set expandtab " Turn tabs into spaces

" Make vertical separator pretty
highlight VertSplit cterm=NONE
set fillchars+=vert:\▏

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Panes and TMUX interaction
""""""""""""""""""""""""""""""""""""""""""""""""""""""

set splitbelow
set splitright

" Write all buffers before navigating from Vim to TMUX pane
let g:tmux_navigator_save_on_switch = 2

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Plugins
""""""""""""""""""""""""""""""""""""""""""""""""""""""

call plug#begin('~/.config/nvim/plugged')
    " Theme
    Plug 'chriskempson/base16-vim'

    " Git
    Plug 'mhinz/vim-signify'
    Plug 'tpope/vim-fugitive'

    " Navigation
    Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
    Plug 'junegunn/fzf.vim'
    Plug 'easymotion/vim-easymotion'

    " Tools
    Plug 'neoclide/coc.nvim', {'branch': 'release'}
    Plug 'honza/vim-snippets'
    Plug 'christoomey/vim-tmux-navigator'
    Plug 'tpope/vim-obsession'
    Plug 'tpope/vim-surround'
    Plug 'jiangmiao/auto-pairs'

    " Programming tools
    Plug 'dart-lang/dart-vim-plugin'
    Plug 'thosakwe/vim-flutter'

    " Writing tools
    Plug 'reedes/vim-pencil'
    Plug 'junegunn/limelight.vim'
    Plug 'tpope/vim-markdown'
    Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
    Plug 'lervag/vimtex'

    " Misc
    Plug 'glacambre/firenvim', { 'do': { _ -> firenvim#install(0) } }
call plug#end()

let g:coc_global_extensions=[
                \ 'coc-snippets',
                \ 'coc-json', 'coc-flutter',
                \ 'coc-vimtex', 'coc-markdownlint'
                \ ]

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color scheme
""""""""""""""""""""""""""""""""""""""""""""""""""""""
syntax enable " Keeps current color settings

set background=dark " Vim tries to use colors best on dark backgrounds
" au Colorscheme * hi Normal guibg=NONE ctermbg=NONE guifg=NONE ctermfg=NONE
" au Colorscheme * hi LineNr guibg=NONE ctermbg=NONE
" au Colorscheme * hi CursorLine guibg=NONE ctermbg=NONE
" au Colorscheme * hi SignColumn guibg=NONE ctermbg=NONE
au Colorscheme * hi Comment ctermfg=DarkGrey
au Colorscheme * hi SpellBad ctermbg=NONE ctermfg=Red cterm=underline
au Colorscheme * hi SpellCap ctermbg=NONE ctermfg=Red cterm=underline
au Colorscheme * hi SpellRare ctermbg=NONE ctermfg=LightGrey
au Colorscheme * hi SpellLocal ctermbg=NONE ctermfg=LightGrey

" if exists('+termguicolors')
"   let &t_8f="\<Esc>[38;2;%lu;%lu;%lum"
"   let &t_8b="\<Esc>[48;2;%lu;%lu;%lum"
"   set termguicolors
" endif

if filereadable(expand("~/.vimrc_background"))
  let base16colorspace=256
  source ~/.vimrc_background
endif

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Status line
""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Turn on status bar
set laststatus=0

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline=%<%f\ %h%m%r\ %y\ COC:
    \\ %{coc#status()}
    \%{get(b:,'coc_current_function','')}%=%l,%c%V\ %P


""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Limelight 
""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Color name (:help cterm-colors) or ANSI code
let g:limelight_conceal_ctermfg = 'gray'
let g:limelight_conceal_ctermfg = 240

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF
""""""""""""""""""""""""""""""""""""""""""""""""""""""

set grepprg=rg\ --vimgrep\ --smart-case\ --follow
nnoremap <silent> <leader><leader> :GFiles<CR>
nnoremap <silent> <leader>f :Rg<CR>

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Easymotion
""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:EasyMotion_do_mapping = 0 " Disable default mappings
let g:EasyMotion_smartcase = 1 " Turn on case-insensitive feature

" Move to character
nmap f <Plug>(easymotion-overwin-f)
xmap f <Plug>(easymotion-f)
omap f <Plug>(easymotion-f)

""""""""""""""""""""""""""""""""""""""""""""""""""""""
" COC
""""""""""""""""""""""""""""""""""""""""""""""""""""""

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Use <leader>l for trigger snippet expand.
imap <leader>l <Plug>(coc-snippets-expand)

" Use <leader>j for select text for visual placeholder of snippet.
vmap <leader>j <Plug>(coc-snippets-select)

" Use <leader>j for jump to next placeholder, it's default of coc.nvim
let g:coc_snippet_next = '<leader>j'

" Use <leader>k for jump to previous placeholder, it's default of coc.nvim
let g:coc_snippet_prev = '<leader>k'

" Use <leader>j for both expand and jump (make expand higher priority.)
imap <leader>j <Plug>(coc-snippets-expand-jump)

" Use <leader>x for convert visual selected code to snippet
xmap <leader>x  <Plug>(coc-convert-snippet)
" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ coc#expandableOrJumpable() ? "\<C-r>=coc#rpc#request('doKeymap', ['snippets-expand-jump',''])\<CR>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

let g:coc_snippet_next = '<tab>'

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>p  <Plug>(coc-format-selected)
nmap <leader>p  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)
" Remap <C-f> and <C-b> for scroll float windows/popups.
" Note coc#float#scroll works on neovim >= 0.4.0 or vim >= 8.2.0750
nnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
nnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
inoremap <nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
inoremap <nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"

" NeoVim-only mapping for visual mode scroll
" Useful on signatureHelp after jump placeholder of snippet expansion
if has('nvim')
  vnoremap <nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#nvim_scroll(1, 1) : "\<C-f>"
  vnoremap <nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#nvim_scroll(0, 1) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>
