set modelines=1
set autoread
set timeoutlen=300
set autoindent
set noshowmode
set nowrap
set hidden
set nojoinspaces
filetype off
filetype plugin indent on

" Tabs
set shiftwidth=4
set softtabstop=4
set tabstop=4
set noexpandtab
set textwidth=80

set wildmenu
set wildmode=list:longest
set wildignore+=.hg,.svn,*~,*.png,*.jpg,*.gif,*.settings,Thumbs.db,*.min.js,*.swp,publish/*,intermediate/*,*.o,*.hi,Zend,vendor
set wildignore+=*/min/*,*/vendor/*,*/node_modules/*,*/bower_components/*

" Ctrl+h to stop searching
vnoremap <C-h> :nohlsearch<cr>
nnoremap <C-h> :nohlsearch<cr>

" Wrapping Options
set formatoptions=tc " wrap text and comments using textwidth
set formatoptions+=r " continue comments when pressing enter
set formatoptions+=q " enable formatting of comments with gq 
set formatoptions+=n " detect lists for formatting 
set formatoptions+=b " auto-wrap in insert mode and do not wrap 
"set colorcolumn=81

" Change cursor style
" https://github.com/neovim/neovim/wiki/FAQ
set guicursor=
autocmd OptionSet guicursor noautocmd set guicurosr=
" Reason :  https://coderwall.com/p/gdowew/vim-tip-map-leader-to-space 
noremap <Space> <Nop>
let mapleader = "\<Space>"
"Custome Mappings"
nnoremap j gj
nnoremap k gk
nnoremap , za
inoremap jk <ESC>
nnoremap Q :q<CR>
nnoremap <Leader>s :w<CR>
nnoremap <C-Left> :tabprevious<CR>
nnoremap <C-Right> :tabnext<CR>
nnoremap <Leader>r :e!<CR>
" do not show q: window
map q: :q
" Split setup
set splitbelow
set splitright
nnoremap <Leader>w <C-W>
" nnoremap <C-J> <C-W><C-J>
" nnoremap <C-K> <C-W><C-K>
nnoremap <C-L> <C-W><C-L>
nnoremap <C-H> <C-W><C-H>

vnoremap <Leader>y "*y
" Popup menu selection keybindings
inoremap <expr> <C-j> pumvisible() ? "\<C-n>" : "\<C-j>"
inoremap <expr> <C-k> pumvisible() ? "\<C-p>" : "\<C-k>"

" Jump to start and end of line
noremap H ^
" Jump to last non blank character in line
noremap L g_
" copy from cursor to end of line
nnoremap Y y$

" Move down file lines
noremap J 5j
vnoremap J 5j
" Move up file lines
noremap K 5k
vnoremap K 5k
" xnoremap <C-/> gc " Don't know how to do this.
noremap <Leader>r :set nu! rnu!<CR>
"some backspace workaround.


set backspace=indent,eol,start
" Vim Plug Configuration
call plug#begin()
Plug 'challenger-deep-theme/vim', { 'as': 'challenger-deep' }
Plug 'tpope/vim-commentary'
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-repeat'
Plug 'junegunn/vim-easy-align'
Plug 'tpope/vim-unimpaired'
"Plug 'rust-lang/rust.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'airblade/vim-rooter'
" Fuzzy Finder Plugins

Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'

call plug#end()
" runtime macros/matchit.vim
" Color configuration
set laststatus=2


"set t_Co=256 
set termguicolors
"Colors
"set background=dark
colorscheme challenger_deep 
" set background=light
" colorscheme base16-atelier-cave-light


"let g:lightline = {
"    \ 'colorscheme': 'challenger_deep',
"    \ 'component_function': {
"    \   'filename': 'LightlineFilename'
"    \ },
"\ }

let g:lightline = {
	\ 'colorscheme': 'challenger_deep',
	\ 'active': {
	\   'left': [ [ 'mode', 'paste' ],
	\             [ 'cocstatus', 'readonly', 'filename', 'modified' ] ]
	\ },
	\ 'component_function': {
	\   'cocstatus': 'coc#status',
  \   'filename' : 'LightlineFilename' 
	\ },
	\ }

" Use auocmd to force lightline update.
autocmd User CocStatusChange,CocDiagnosticChange call lightline#update()
function! LightlineFilename()
      let filename = expand('%:t') !=# '' ? expand('%:t') : '[No Name]'
      let modified = &modified ? '*' : ''
      return filename . modified
endfunction

" ~/.viminfo needs to be writable and readable. Set oldfiles to 1000 last
" recently opened files, :FzfHistory uses it
set viminfo='1000

if has('persistent_undo')
set undofile
set undodir=~/.cache/vim
endif

set shiftwidth=0
set tabstop=2 " number of visual spaces per TAB
set softtabstop=4 " number of spaces in tab when editing
set expandtab " convert TAB to spaces
set wrap
set autoindent
filetype on
filetype plugin indent on

set scrolloff=2
set noswapfile " Don't use Swapfile
set nobackup " Don't create backup

" show syntax highlighting for large files
" set maxmempattern=20000
" Use below when problem with wrapping.
" nnoremap <expr> j (v:count == 0 ? 'gj' : 'j')
" nnoremap <expr> k (v:count == 0 ? 'gk' : 'k')

" moving up and down
" noremap <C-d> <C-d>zz
" noremap <C-u> <C-u>zz
set incsearch
set ignorecase
set smartcase
set gdefault
nnoremap <silent> n nzz
nnoremap <silent> N Nzz
nnoremap <silent> * *zz
nnoremap <silent> # #zz
nnoremap <silent> g* g*zz
" To be formatted letter
" Vim Easy Align mappings
xmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

" Coc Settings
" Copied from README 
" https://github.com/neoclide/coc.nvim
set hidden
set nobackup
set nowritebackup

set cmdheight=2
set updatetime=300

" dont't give |ins-completion-menu | messages
set shortmess+=c
set signcolumn=yes

let g:rooter_patterns = ['go.mod', '.git/', 'Cargo.toml']
" coc config
let g:coc_global_extensions = [
    \ 'coc-json',
    \ 'coc-python',
    \ ]
" Use tab for trigger completion with characters ahead and navigate.
" Use command ':verbose imap <tab>' to make sure tab is not mapped by other plugin.
"inoremap <silent><expr> <TAB>
"    \ pumvisible() ? "\<C-n>" :
"    \ <SID>check_back_space() ? "\<TAB>" :
"    \ coc#refresh()
"inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
let col = col('.') - 1
return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
" Or use `complete_info` if your vim support it, like:
" inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[d` and `]d` to navigate diagnostics
nmap <silent> [d <Plug>(coc-diagnostic-prev)
nmap <silent> ]d <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)
" Use K to show documentation in preview window
nnoremap <silent> <C-k> :call <SID>show_documentation()<CR>
"nnoremap <silent> <Leader>K :call <SID>show_documentation()<CR>

function! s:show_documentation()
if (index(['vim','help'], &filetype) >= 0)
  execute 'h '.expand('<cword>')
else
  call CocAction('doHover')
endif
endfunction

" Highlight symbol under cursor on CursorHold
autocmd CursorHold * silent call CocActionAsync('highlight')

" Remap for rename current word
nmap <leader>rn <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
autocmd!
" Setup formatexpr specified filetype(s).
autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
" Update signature help on jump placeholder
autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
autocmd FileType python let b:coc_root_patterns = ['.git', 'env']
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use <C-d> for select selections ranges, needs server support, like: coc-tsserver, coc-python
nmap <silent> <C-d> <Plug>(coc-range-select)
xmap <silent> <C-d> <Plug>(coc-range-select)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

nnoremap <Leader>i :OR<CR>
" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> ,d  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> ,e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> ,c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> ,o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> ,s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> ,j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> ,k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> ,p  :<C-u>CocListResume<CR>

nnoremap <silent> ff :Files<cr>
nnoremap <silent> fg :Rg<cr>

