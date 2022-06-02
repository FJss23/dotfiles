call plug#begin('~/.local/share/nvim/plugged')

" Lsp
Plug 'neovim/nvim-lspconfig' " Native lsp
Plug 'hrsh7th/cmp-nvim-lsp' " Better lsp experience
Plug 'hrsh7th/cmp-buffer' " Source for buffer words
Plug 'hrsh7th/cmp-path' " Source for fylesystem paths
Plug 'hrsh7th/nvim-cmp' " Completion engine

" Colors
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Syntax highlight
Plug 'sainnhe/everforest' " Hopefully my main colorscheme, kidding

" Utils
Plug 'norcalli/nvim-colorizer.lua' " Show colors
Plug 'numToStr/Comment.nvim' " Better comments
Plug 'mattn/emmet-vim' " Better html
Plug 'lukas-reineke/indent-blankline.nvim' " Indent lines
Plug 'mbbill/undotree' " Keep track of history
Plug 'romgrk/nvim-treesitter-context' " Better context
Plug 'kyazdani42/nvim-web-devicons' " Is this an IDE??
Plug 'gpanders/editorconfig.nvim' " Don't mess with indentation and stuff

" Git
Plug 'tpope/vim-fugitive' " Illegal plugin
Plug 'nvim-lua/plenary.nvim' " Required for gitsigns
Plug 'lewis6991/gitsigns.nvim' " Git info

" Snippets
Plug 'L3MON4D3/LuaSnip' " Snippets superpowers
Plug 'saadparwaiz1/cmp_luasnip' " Required for luasnip

" Search
Plug 'ibhagwan/fzf-lua', {'branch': 'main'}
Plug 'kyazdani42/nvim-tree.lua' " Explorer

call plug#end()

" Options
set path+=**
set signcolumn=yes
set autoindent
set smartindent
set tabstop=2 " tabs are 2 spaces
set softtabstop=2 " tabs are 2 spaces
set shiftwidth=2 " >> use 2 spaces
set expandtab
set hidden
set nobackup
set noswapfile
set incsearch hlsearch
set scrolloff=10
set completeopt=menu,noinsert,noselect
set mouse=a
set nuw=4
syntax on
filetype plugin indent on
set spelllang=en
set spellsuggest=best,9
set wildmenu
set wildmode=longest,list,full
set wildignore+=*.png,*.jpg,*jpg,*/.git/*,*/node_modules/*
set wildoptions+=pum
set nowrap
set number
set termguicolors
set cursorline
set background=dark
set pumblend=15
let g:everforest_background = 'hard'
colorscheme everforest
hi CursorLine guibg=NONE
hi CursorLineNr guibg=NONE guifg=gold3 gui=bold
hi Search guibg=bisque2
hi QuickFixLine guibg=bisque2 guifg=black
hi StatusLine guifg=bisque2

" Config for emmet
autocmd FileType html,javascript,typescript,js,ts,jsx,tsx EmmetInstall
autocmd BufWinEnter,WinEnter *.svelte set syntax=html

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
nnoremap <leader>fd :find 
nnoremap <leader>rg :Rgrep 


" Move lines
:tnoremap fd <C-\><C-n>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv


" Resize
noremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>


" Buffer manipulation
nnoremap <leader><leader> <c-^>
nnoremap <leader>, :ls<cr>:b<space>
nnoremap <leader>bk :bp\|bd! #<CR>
nnoremap <leader>bq :BufOnly <CR>


" Quickfix list manipulation
nnoremap <leader>co :copen<CR>
nnoremap <leader>ck :cclose<CR>
nnoremap <leader>cf :cfirst<CR>
nnoremap <leader>cl :cclast<CR>
nnoremap <leader>cn :cnext<CR>
nnoremap <leader>cp :cprevious<CR>


" Location list manipulation
nnoremap <leader>lo :lopen<CR>
nnoremap <leader>lk :lclose<CR>
nnoremap <leader>ln :lnext<CR>
nnoremap <leader>lp :lprevious<CR>


" Tab manipulation
au TabLeave * let g:lasttab = tabpagenr()
nnoremap <leader>ñ :exe "tabn ".g:lasttab<cr>
nnoremap <leader>tk :tabclose<cr>
nnoremap <leader>tn :tabnew<cr>


nnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
inoremap <silent><c-t> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>

" Marks
nnoremap <leader>md :delm!<CR> :delm A-Z0-9<CR>


" Indentation for file types
autocmd FileType html,javascript,typescript,js,ts,jsx,tsx,pug,javascriptreact,typescriptreact 
      \ setlocal shiftwidth=2 tabstop=2


" Close all buffers except current
command! BufOnly execute '%bdelete|edit #|normal `"'


" grep + quickfix list. Source: https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3
function! Rgrep(...)
    return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
endfunction

command! -nargs=+ -complete=file_in_path -bar Rgrep  cgetexpr Rgrep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LRgrep lgetexpr Rgrep(<f-args>)

" Don't show the preview after grep
augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost cgetexpr cwindow
    autocmd QuickFixCmdPost lgetexpr lwindow
augroup END

" https://vim.fandom.com/wiki/Search_for_current_word_in_multiple_files
:nnoremap ñ :Rgrep <cword> *<CR> " searches for the text in the word under the cursor (like g*) in any of the files in the current directory. 
:nnoremap <leader>ñ :Rgrep <cword> %:p:h/*<CR> " searches for the text in the word under the cursor (like g*) in any of the files in the same directory as the current file
:nnoremap ç :Rgrep '\b<cword>\b' *<CR> " searches for the whole word under the cursor (like *) in any of the files in the current directory
:nnoremap <leader>ç :Rgrep '\b<cword>\b' %:p:h/*<CR> " searches for the whole word under the cursor (like *) in any of the files in the same directory as the current file. 

let g:term_buf = 0
let g:term_win = 0

function! TermToggle(height)
    if win_gotoid(g:term_win)
        hide
    else
        botright new
        exec "resize " . a:height
        try
            exec "buffer " . g:term_buf
        catch
            call termopen($SHELL, {"detach": 0})
            let g:term_buf = bufnr("")
            set nonumber
            set norelativenumber
            set signcolumn=no
        endtry
        startinsert!
        let g:term_win = win_getid()
    endif
endfunction

tnoremap <esc> <C-\><C-n>
tnoremap <C-v><esc> <esc>
tnoremap <C-h> <C-\><C-n><C-w>h
tnoremap <C-j> <C-\><C-n><C-w>j
tnoremap <C-k> <C-\><C-n><C-w>k
tnoremap <C-l> <C-\><C-n><C-w>l
nnoremap <A-t> :call TermToggle(12)<CR>
inoremap <A-t> <Esc>:call TermToggle(12)<CR>
tnoremap <A-t> <C-\><C-n>:call TermToggle(12)<CR>
autocmd BufWinEnter,WinEnter term://* startinsert

nnoremap <F8> :UndotreeToggle<CR>

lua <<EOF
require('lsp')
require('treesitter')
require('utils')
require('statusline')
EOF
