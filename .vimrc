let mapleader = " "

call plug#begin('~/.vim/plugged')
Plug 'Yggdroot/indentLine'
Plug 'inkarkat/vim-SyntaxRange'
Plug 'mattn/emmet-vim'
Plug 'jceb/vim-orgmode'
Plug 'majutsushi/tagbar'
Plug 'nightsense/vimspectr'
Plug 'scrooloose/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-speeddating'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()

set nocompatible
filetype plugin on
syntax on
syntax enable
inoremap ., <Esc>

function! MyHighlights() abort
    highlight FoldColumn  cterm=NONE ctermbg=black                    gui=NONE guibg=black
    highlight Folded      cterm=NONE ctermbg=black                    gui=NONE guibg=black
"    highlight Visual      cterm=NONE ctermbg=White   ctermfg=DarkGrey gui=NONE guibg=white    guifg=DarkGrey
    highlight ColorColumn cterm=NONE ctermbg=magenta ctermfg=DarkGrey gui=NONE guifg=DarkGrey guibg=magenta
endfunction

augroup MyColors
    autocmd!
    autocmd ColorScheme * call MyHighlights()
augroup END

autocmd BufRead,BufNewFile *.md set tw=79
autocmd BufWritePre * %s/\s\+$//e
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
colorscheme desert
imap <C-s> <esc>:w<CR>
map K <Nop>
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <C-p> "+P
map <C-s> <esc>:w<CR>
map <C-t> <esc>:tabnew<CR>
map <F6> :setlocal spell! spelllang=en_us<CR>
map <Leader>co mmggVG"*y`m
map <Leader>ch :call matchadd('ColorColumn', '\%81v', 100)<CR>
map <Leader>cn :call clearmatches()<CR>
map <Leader>e :e <C-R>=escape(expand("%:p:h"),' ') . '/'<CR>
map <Leader>f mmgqap`m:w<CR>
map <Leader>h :noh<CR>
map <Leader>i mmgg=G`m
map <Leader>pi :PlugInstall<CR>
map <Leader>pu :PlugUpdate<CR>
nmap <Leader>sc :vsp<CR>
nmap <Leader>sf <C-w>_<C-w>|
nmap <Leader>sn <C-w>=
nmap <Leader>so <C-w>o
nmap <Leader>st <C-w>t
nmap <Leader>vg :vsp<CR>:vimgrep
nmap <Leader>vrc :tabedit $MYVIMRC<CR>
nnoremap <C-y> g+
nnoremap <C-z> g-
nnoremap <F1> :Utl<CR>
nnoremap <F3> :noh<CR>
nnoremap S :%s//g<Left><Left>
noremap <Leader>s :update<CR>
set autoindent
set autoread
set backspace=indent,eol,start
set backupdir=~/.vim/backup//
set bg=dark
set clipboard=unnamed
set cmdheight=2
set complete-=i
set cursorline
set encoding=utf-8
set expandtab
set foldenable
set foldmethod=syntax
set hlsearch
set incsearch
set laststatus=2
set mouse=a
set nrformats-=octal
set number
set ruler
set scrolloff=5
set sessionoptions-=options
set shiftwidth=4
set shortmess=at
set smarttab
set softtabstop=4
set splitbelow
set splitright
set tabstop=4
set viewoptions-=options
set wildmenu
set wildmode=longest,list,full
vnoremap <C-c> "*Y :let @+=@*<CR>
vnoremap H <gv
vnoremap L >gv
