let mapleader = " "

call plug#begin()
    Plug 'neovim/nvim-lspconfig'
    Plug 'nvim-lua/plenary.nvim'
    Plug 'SirVer/ultisnips' | Plug 'honza/vim-snippets'
    Plug 'hrsh7th/cmp-buffer'                            
    Plug 'hrsh7th/cmp-nvim-lsp'
    Plug 'hrsh7th/cmp-nvim-lsp-signature-help'
    Plug 'hrsh7th/cmp-nvim-lua'
    Plug 'hrsh7th/cmp-path'                              
    Plug 'hrsh7th/cmp-vsnip'                             
    Plug 'hrsh7th/nvim-cmp' 
    Plug 'hrsh7th/vim-vsnip'                             
    Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
    Plug 'ms-jpq/coq.artifacts', {'branch': 'artifacts'}
    Plug 'ms-jpq/coq_nvim', {'branch': 'coq'}
    Plug 'ncm2/ncm2'
    Plug 'ncm2/ncm2-bufword'
    Plug 'ncm2/ncm2-jedi'
    Plug 'ncm2/ncm2-path'
    Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
    Plug 'roxma/nvim-yarp'
    Plug 'saecki/crates.nvim', { 'tag': 'v0.3.0' }
    Plug 'simrat39/rust-tools.nvim'
    Plug 'williamboman/mason-lspconfig.nvim'
    Plug 'williamboman/mason.nvim', { 'do': ':MasonUpdate' }
call plug#end()

lua << EOF
require('crates').setup()
require('mason').setup({
    ui = {
        icons = {
            package_installed = "",
            package_pending = "",
            package_uninstalled = "",
        },
    }
})
require('mason-lspconfig').setup()
local rt = require("rust-tools")
rt.setup({
  server = {
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
})
require('rust-tools').inlay_hints.enable()
require('rust-tools').hover_actions.hover_actions()
local sign = function(opts)
  vim.fn.sign_define(opts.name, {
    texthl = opts.name,
    text = opts.text,
    numhl = ''
  })
end
require('nvim-treesitter.configs').setup {
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting=false,
  },
  ident = { enable = true }, 
  rainbow = {
    enable = true,
    extended_mode = true,
    max_file_lines = nil,
  }
}

sign({name = 'DiagnosticSignError', text = ''})
sign({name = 'DiagnosticSignWarn', text = ''})
sign({name = 'DiagnosticSignHint', text = ''})
sign({name = 'DiagnosticSignInfo', text = ''})

vim.diagnostic.config({
    virtual_text = false,
    signs = true,
    update_in_insert = true,
    underline = true,
    severity_sort = false,
    float = {
        border = 'rounded',
        source = 'always',
        header = '',
        prefix = '',
    },
})
local cmp = require'cmp'
cmp.setup({
  snippet = {
    expand = function(args)
        vim.fn["vsnip#anonymous"](args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<S-Tab>'] = cmp.mapping.select_prev_item(),
    ['<Tab>'] = cmp.mapping.select_next_item(),
    ['<C-S-f>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm({
      behavior = cmp.ConfirmBehavior.Insert,
      select = true,
    })
  },
  sources = {
    { name = 'path' },                              -- file paths
    { name = 'nvim_lsp', keyword_length = 3 },      -- from language server
    { name = 'nvim_lsp_signature_help'},            -- display function signatures with current parameter emphasized
    { name = 'nvim_lua', keyword_length = 2},       -- complete neovim's Lua runtime API such vim.lsp.*
    { name = 'buffer', keyword_length = 2 },        -- source current buffer
    { name = 'vsnip', keyword_length = 2 },         -- nvim-cmp source for vim-vsnip 
    { name = 'calc'},                               -- source for math calculation
  },
  window = {
      completion = cmp.config.window.bordered(),
      documentation = cmp.config.window.bordered(),
  },
  formatting = {
      fields = {'menu', 'abbr', 'kind'},
      format = function(entry, item)
          local menu_icon ={
              nvim_lsp = 'λ',
              vsnip = '⋗',
              buffer = 'Ω',
              path = '🖫',
          }
          item.menu = menu_icon[entry.source.name]
          return item
      end,
  },
})
EOF

colorscheme goodcolor
set nocompatible
filetype plugin on
syntax on
syntax enable
inoremap ., <Esc>

function! MyHighlights() abort
    highlight FoldColumn  cterm=NONE ctermbg=black                    gui=NONE guibg=black
    highlight Folded      cterm=NONE ctermbg=black                    gui=NONE guibg=black
"   highlight Visual      cterm=NONE ctermbg=White   ctermfg=DarkGrey gui=NONE guibg=white    guifg=DarkGrey
    highlight ColorColumn cterm=NONE ctermbg=235 ctermfg=LightGrey gui=NONE guifg=LightGrey guibg=DarkGrey
endfunction

augroup MyColors
    autocmd!
    autocmd ColorScheme * call MyHighlights()
augroup END

autocmd BufEnter * call ncm2#enable_for_buffer()
autocmd BufRead,BufNewFile *.md set tw=79
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
autocmd FileType * setlocal formatoptions-=c formatoptions-=r formatoptions-=o
command! W write
imap <C-s> <esc>:w<CR>
let g:python3_host_prog = 'G:\sum1Programs\Python3.10.10\python.exe'
map <C-h> <C-w>h
map <C-j> <C-w>j
map <C-k> <C-w>k
map <C-l> <C-w>l
map <C-p> "+P
map <C-s> <esc>:w<CR>
map <C-t> <esc>:tabnew<CR>
map <F6> :setlocal spell! spelllang=en_us<CR>
map <Leader>ba :ball<CR>
map <Leader>bd :bdelete<CR>
map <Leader>bn :bnext<CR>
map <Leader>bu :buffers<CR>
map <Leader>ch :call matchadd('ColorColumn', '\%81v', 100)<CR>
map <Leader>cn :call clearmatches()<CR>
map <Leader>co mmggVG"*y`m
map <Leader>e :e <C-R>=escape(expand("%:p:h"),' ') . '/'<CR>
map <Leader>f mmgqap`m:w<CR>
map <Leader>h :noh<CR>
map <Leader>i mmgg=G`m
nmap <Leader>q :q<CR>
nmap <Leader>sc :vsp<CR>
nmap <Leader>sf <C-w>_<C-w>|
nmap <Leader>sh <C-w><
nmap <Leader>sl <C-w>>
nmap <Leader>sn <C-w>=
nmap <Leader>so <C-w>o
nmap <Leader>st <C-w>t
nmap <Leader>vg :vsp<CR>:vimgrep
nmap <Leader>vrc :tabedit $MYVIMRC<CR>
nnoremap <C-y> g+
nnoremap <C-z> g-
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
set completeopt=noinsert,menuone,noselect
set cursorline
set encoding=utf-8
set expandtab
set foldmethod=syntax
set hlsearch
set incsearch
set laststatus=2
set mouse=a
set nofoldenable
set nrformats-=octal
set number
set ruler
set scrolloff=5
set sessionoptions-=options
set shiftwidth=4
set shortmess=at
set signcolumn=yes
set smarttab
set softtabstop=4
set spellfile=~/.mydict.utf-8.add
set splitbelow
set splitright
set tabstop=4
set viewoptions-=options
set wildmenu
set wildmode=longest,list,full
vnoremap <C-c> "*Y :let @+=@*<CR>
vnoremap H <gv
vnoremap L >gv

if exists("g:neovide")
  let g:neovide_refresh_rate=144
  let g:neovide_cursor_animation_length=0.03
  let g:neovide_cursor_trail_length=0.2
  let g:neovide_cursor_vfx_mode = "pixiedust"
endif
