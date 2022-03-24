call plug#begin('~/.local/share/nvim/plugged')

" Lsp
Plug 'neovim/nvim-lspconfig' " Native lsp
Plug 'hrsh7th/cmp-nvim-lsp' " Better lsp experience
Plug 'hrsh7th/cmp-buffer' " Source for buffer words
Plug 'hrsh7th/cmp-path' " Source for fylesystem paths
Plug 'hrsh7th/nvim-cmp' " Completion engine

" Colors
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Syntax highlight
Plug 'sainnhe/sonokai' " Color scheme
" Plug 'sainnhe/gruvbox-material' " Color scheme
Plug 'norcalli/nvim-colorizer.lua' " Show colors

" Utils
Plug 'tpope/vim-commentary' " Better comments
Plug 'mattn/emmet-vim' " Better html
Plug 'kkoomen/vim-doge' " Easy docs
Plug 'windwp/nvim-ts-autotag' " Modify tag easily

" Git
Plug 'nvim-lua/plenary.nvim' " Required for gitsigns
Plug 'lewis6991/gitsigns.nvim' " Git info while editing
" Plug 'sindrets/diffview.nvim' " Better check before commit

" Snippets
Plug 'L3MON4D3/LuaSnip' " Snippets superpower
Plug 'saadparwaiz1/cmp_luasnip' " Required for luasnip

" Search
" Plug 'kyazdani42/nvim-tree.lua'  " Better file explorer
Plug 'tpope/vim-vinegar'
Plug 'junegunn/fzf.vim' " Search superpower

call plug#end()


" Options
set path+=**
set signcolumn=yes
set tabstop=4 
set softtabstop=4
set shiftwidth=4
set expandtab
set smartindent
" set guicursor=
set hidden
set nobackup
set noswapfile
set incsearch hlsearch
set scrolloff=10
set termguicolors
set completeopt=menu,noinsert,noselect
set mouse=a
set nuw=4
syntax on
filetype plugin indent on
set spelllang=en
set spellsuggest=best,9
highlight Normal ctermbg=none
highlight NonText ctermbg=none
set rtp+=~/.fzf
set wildmenu
set wildmode=longest,list,full
set wildignore+=*.png,*.jpg,*jpg,*/.git/*,*/node_modules/*
set statusline=\ [\ %{b:git_branch}]\ %<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set nowrap
set colorcolumn=90       
set number relativenumber 
set list lcs=tab:\|\ 
set cursorline
set background=dark
" let g:gruvbox_material_background = 'medium'
" let g:gruvbox_material_better_performance = 1
" let g:gruvbox_material_pallete = 'original'
" colorscheme gruvbox-material
" hi Comment guifg=#82878b
let g:sonokai_better_performance = 1
let g:sonokai_style = 'maia'
colorscheme sonokai
hi Comment guifg=#82878b


" Config for emmet
autocmd FileType html,javascript,typescript,js,ts,jsx,tsx EmmetInstall


" Wild things can happens if I enable this
" command! MakeTags !ctags -R .


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
nnoremap <silent> <F2> :set spell!<cr>
inoremap <silent> <F2> <C-O>:set spell!<cr>
inoremap ñ {
inoremap Ñ }
inoremap ç [
inoremap Ç ]


" Move lines
:tnoremap jk <C-\><C-n>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv


" Resize
noremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>


" Buffer manipulation
nnoremap <leader><leader> <c-^>
nnoremap <leader>bb :ls<cr>:b<space>
nnoremap <Leader>bk :bp\|bd! #<CR>


" Quickfix list manipulation
nnoremap <leader>co :copen<CR>
nnoremap <leader>cq :cclose<CR>
nnoremap <leader>cf :cfirst<CR>
nnoremap <leader>cl :cclast<CR>
nnoremap <leader>ch :col<CR>
nnoremap <leader>cl :cnew<CR>
nnoremap <C-j> :cnext<CR>
nnoremap <C-k> :cprev<CR>


" Location list manipulation
nnoremap <leader>lo :lopen<CR>
nnoremap <leader>lq :cclose<CR>
nnoremap <leader>j :lnext<CR>
nnoremap <leader>k :lprev<CR>


" Tab manipulation
au TabLeave * let g:lasttab = tabpagenr()
nnoremap <leader>ñ :exe "tabn ".g:lasttab<cr>
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
nnoremap <silent> <leader>fw :Rg <C-R><C-W><CR>
nnoremap <leader>fo :find 
nnoremap <leader>fr :Grep 


" https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3
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


" Indentation for file types
autocmd FileType html,javascript,typescript,js,ts,jsx,tsx,pug setlocal shiftwidth=2 tabstop=2


" FZF style
let g:fzf_preview_window = []


" When using FZF and Rg, I don't want to include file names
command! -bang -nargs=* Rg
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)


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
