call plug#begin('~/.local/share/nvim/plugged')

" Lsp
Plug 'neovim/nvim-lspconfig' " Native lsp
Plug 'hrsh7th/cmp-nvim-lsp' " Better lsp experience
Plug 'hrsh7th/nvim-cmp' " Better lsp experience

" Colors
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Syntax highlight
Plug 'romainl/Apprentice' " Colorscheme option

" Utils
Plug 'numToStr/Comment.nvim' " Better comments
Plug 'mattn/emmet-vim' " Better html
Plug 'windwp/nvim-autopairs' " Auto close paired characters
Plug 'nvim-lua/plenary.nvim' " Required for gitsigns
Plug 'lewis6991/gitsigns.nvim' " Git info
Plug 'norcalli/nvim-colorizer.lua' " Show colors
Plug 'lukas-reineke/indent-blankline.nvim' " Show indentation
Plug 'windwp/nvim-ts-autotag' " Easy html tag manipulation
Plug 'editorconfig/editorconfig-vim' " Style for every project
Plug 'kkoomen/vim-doge' " Easy docs

" Snippets
Plug 'L3MON4D3/LuaSnip' " Snippets superpower
Plug 'saadparwaiz1/cmp_luasnip' " Required for luasnip

" Search
Plug 'kyazdani42/nvim-tree.lua'  " Better file explorer
Plug 'junegunn/fzf.vim' " Search superpower

call plug#end()


" Options
set path+=**
set signcolumn=yes
set colorcolumn=100
set tabstop=4 
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
set guicursor=
set hidden
set nobackup
set noswapfile
set incsearch hlsearch
set scrolloff=10
set termguicolors
set completeopt=menu,noinsert,noselect
set mouse=a
set nuw=4
set background=dark
set cursorline
syntax on
filetype plugin indent on
set spelllang=en
set spellsuggest=best,9
highlight Normal ctermbg=none
highlight NonText ctermbg=none
set rtp+=~/.fzf
set wildignore+=*.png,*.jpg,*jpg,*/.git/*,*/node_modules/*
set nonumber 
set statusline=\ [%{b:git_branch}]\ %<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
colorscheme apprentice


" Config for emmet
autocmd FileType html,javascript,typescript,js,ts,jsx,tsx,vue EmmetInstall


" Config for term
autocmd TermOpen * setlocal nonumber


" Use ripgrep instead of grep
if executable("rg")
    set grepprg=rg\ --vimgrep\ --smart-case\ --hidden
    set grepformat=%f:%l:%c:%m
endif


" General stuff
let mapleader=" "
:imap jk <Esc>
nnoremap <leader>s :update<cr>
nnoremap <leader>q :q<cr>
nnoremap <silent> <F2> :set invnumber <cr>
nnoremap <silent> <F4> :set spell!<cr>
inoremap <silent> <F4> <C-O>:set spell!<cr>


" Move lines
:tnoremap jk <C-\><C-n>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv


" Split navigation
nnoremap <leader>h <C-w>h
nnoremap <leader>j <C-w>j
nnoremap <leader>k <C-w>k
nnoremap <leader>l <C-w>l


" Resize
noremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>


" Buffer manipulation
nnoremap <leader>b. <c-^>
nnoremap <leader>bb :ls<cr>:b<space>
nnoremap <Leader>bk :bp\|bd! #<CR>
nnoremap <leader>bh :bnext<CR>
nnoremap <leader>bl :bprevious<CR>


" Tab manipulation
au TabLeave * let g:lasttab = tabpagenr()
nnoremap <silent> <leader>t. :exe "tabn ".g:lasttab<cr>
nnoremap <leader>tk :tabclose<cr>
nnoremap <leader>tn :tabnew<cr>


" Terminal manipulation
nnoremap <leader>ot :tabnew<CR>:term<CR>i
nnoremap <leader>ov :vsplit<CR>:term<CR>i
nnoremap <leader>os :split<CR>:term<CR>i


" FZF
nnoremap <silent> <leader>ff :Files<CR>
nnoremap <silent> <leader>fg :Rg<CR>
nnoremap <silent> <leader>fb :Buffers<CR>
nnoremap <silent> <Leader>fw :Rg <C-R><C-W><CR>


" FZF style
let g:fzf_preview_window = []
let g:fzf_layout = { 'down': '~30%' }


" FZF and Rg, only search for content
command! -bang -nargs=* Rg
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)

nnoremap <leader>r :Grep <C-R><C-W><CR>

" Populate the result of grep into quickfix list
function! Grep(...)
    return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
endfunction

command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr Grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr Grep(<f-args>)

augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost cgetexpr cwindow
    autocmd QuickFixCmdPost lgetexpr lwindow
augroup END

cnoreabbrev <expr> grep (getcmdtype() ==# ':' && getcmdline() ==# 'grep') ? 'Grep' : 'grep'

" Populate the result of find into quickfix list
fun! FindFiles(filename)
    let error_file = tempname()
    silent exe '!find . -name "'.a:filename.'" | xargs file | sed "s/:/:1:/" > '.error_file
    set errorformat=%f:%l:%m
    exe "cfile ". error_file
    copen
    call delete(error_file)
endfun

command! -nargs=1 FindFile call FindFiles(<q-args>)

" Show current branch on status line
function Gitbranch()
    return trim(system("git -C " . expand("%:h") . " branch --show-current 2>/dev/null"))
endfunction

augroup Gitget
    autocmd!
    autocmd BufEnter * let b:git_branch = Gitbranch()
augroup END

lua <<EOF
-- Configuration of Lua plugins
require('lsp')
require('treesitter')
require('utils')
EOF
