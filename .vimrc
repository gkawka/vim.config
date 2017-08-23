" ~/.vimrc na podstawie http://www.oliversherouse.com/2017/08/21/vim_zero.html

" Built-In Functionality
"" General
let mapleader = ','

set hidden " Allow background buffers without saving
set spell spelllang=en_us
set splitright " Split to right by default

"" Text Wrapping
set textwidth=79
set colorcolumn=80
set nowrap

"" Search and Substitute
set gdefault " use global flag by default in s: commands
set hlsearch " highlight searches
set ignorecase 
set smartcase " don't ignore capitals in searches
nnoremap <leader><space> :nohls <enter>

"" Tabs
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab

""" NetRW
let g:netrw_liststyle = 1 " Detail View
let g:netrw_sizestyle = "H" " Human-readable file sizes
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+' " hide dotfiles
let g:netrw_hide = 1 " hide dotfiles by default
let g:netrw_banner = 0 " Turn off banner

"""" With hidden files
let g:netrw_list_hide = '^\./$'
let g:netrw_hide = 1
""" Explore in vertical split
nnoremap <Leader>e :Explore! <enter>

"" Mappings
nnoremap ; :
nnoremap <C-H> :bp <enter>
nnoremap <C-L> :bn <enter>
nnoremap <Leader>w :w <enter>
nnoremap <Leader>q :bd <enter>

noremap <Leader>x "+

"" Python Version
augroup python3
    au! BufEnter *.py setlocal omnifunc=python3complete#Complete
augroup END

" Plugins 

"" Installation with VimPlug
if has("win32")
    call plug#begin('~/vimfiles/plugged')
else
    call plug#begin('~/.vim/plugged')
endif

""" Basics
Plug 'tpope/vim-sensible'
Plug 'sheerun/vim-polyglot'
Plug 'flazz/vim-colorschemes'

""" General Functionality
Plug 'kien/ctrlp.vim'
Plug 'lifepillar/vim-mucomplete'
Plug 'scrooloose/syntastic'
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'tpope/vim-commentary'
Plug 'chiel92/vim-autoformat'

""" Particular Functionality
Plug 'junegunn/goyo.vim'
Plug 'junegunn/limelight.vim'
Plug 'vim-pandoc/vim-pandoc-syntax'
Plug 'godlygeek/tabular'

""" Testing
Plug 'altercation/vim-colors-solarized'

call plug#end()


"" Colors
syntax enable
set background=dark
colorscheme solarized


" # set termguicolors
" # colorscheme darth

"" Autocompletion
set completeopt=menuone,noinsert,noselect
set shortmess+=c " Turn off completion messages

inoremap <expr> <c-e> mucomplete#popup_exit("\<c-e>")
inoremap <expr> <c-y> mucomplete#popup_exit("\<c-y>")
inoremap <expr>  <cr> mucomplete#popup_exit("\<cr>")

let g:mucomplete#enable_auto_at_startup = 1 

"" Autoformat
au! BufWrite * :Autoformat
let g:autoformat_autoindent = 0
let g:autoformat_retab = 0
let g:autoformat_remove_trailing_spaces = 0

augroup markdown_flavor
    au! BufNewFile,BufFilePre,BufRead *.md 
                \ let b:markdown_flavor="markdown"
    au! BufNewFile,BufFilePre,BufRead *.markdown
                \ let b:markdown_flavor="markdown"
    au! BufNewFile,BufFilePre,BufRead */blog/*.markdown
                \ let b:markdown_flavor="markdown_github".
                \"+footnotes".
                \"+yaml_metadata_block".
                \"-hard_line_blocks"
augroup END

let g:formatdef_pandoc =
            \'"pandoc  --standalone --atx-headers --columns=79'.
            \' -f markdown -t ".b:markdown_flavor'
let g:formatters_markdown_pandoc = ['pandoc']

"" CtrlP
let g:ctrlp_show_hidden = 1

"" Goyo & Limelight
autocmd! User GoyoEnter Limelight
autocmd! User GoyoLeave Limelight!

"" Pandoc
augroup pandoc_syntax
    au! BufNewFile,BufFilePre,BufRead *.md set filetype=markdown.pandoc
    au! BufNewFile,BufFilePre,BufRead *.markdown set filetype=markdown.pandoc
augroup END

let g:pandoc#syntax#conceal#use = 0
let g:pandoc#syntax#codeblocks#embeds#langs = ['python', 'vim', 'make',
            \  'bash=sh', 'html', 'css', 'scss', 'javascript']

