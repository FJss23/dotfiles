call plug#begin('~/.local/share/nvim/plugged')

" Lsp
Plug 'neovim/nvim-lspconfig' " Native lsp
Plug 'hrsh7th/cmp-nvim-lsp' " Better lsp experience
Plug 'hrsh7th/cmp-buffer' " Source for buffer words
Plug 'hrsh7th/cmp-path' " Source for fylesystem paths
Plug 'hrsh7th/nvim-cmp' " Completion engine

" Colors
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Syntax highlight
Plug 'sainnhe/gruvbox-material'

" Utils
Plug 'norcalli/nvim-colorizer.lua' " Show colors
Plug 'tpope/vim-commentary' " Better comments
Plug 'mattn/emmet-vim' " Better html
Plug 'lukas-reineke/indent-blankline.nvim' " Indent lines
Plug 'windwp/nvim-autopairs' " Auto close
Plug 'p00f/nvim-ts-rainbow' " Colored characters
Plug 'abecodes/tabout.nvim' " Easy scaping character
Plug 'kevinhwang91/nvim-bqf' " Qf list superpowers
Plug 'romgrk/nvim-treesitter-context' " Better context

" Git
Plug 'nvim-lua/plenary.nvim' " Required for gitsigns
Plug 'lewis6991/gitsigns.nvim' " Git info

" Snippets
Plug 'L3MON4D3/LuaSnip' " Snippets superpowers
Plug 'saadparwaiz1/cmp_luasnip' " Required for luasnip

" Search
Plug 'junegunn/fzf.vim' " Search superpowers

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
set termguicolors
set completeopt=menu,noinsert,noselect
set mouse=a
set nuw=4
syntax on
filetype plugin indent on
set spelllang=en
set spellsuggest=best,9
set rtp+=~/.fzf
set wildmenu
set wildmode=longest,list,full
set wildignore+=*.png,*.jpg,*jpg,*/.git/*,*/node_modules/*
set nowrap
set colorcolumn=90
set number "relativenumber
" set noshowmode
set cursorline
set background=dark


let g:gruvbox_material_palette = 'original'
let g:gruvbox_material_background = 'medium'
let g:gruvbox_material_enable_bold = 1
let g:gruvbox_material_better_performance = 1
colorscheme gruvbox-material

" Config for emmet
autocmd FileType html,javascript,typescript,js,ts,jsx,tsx EmmetInstall


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
nnoremap <leader>, :ls<cr>:b<space>
nnoremap <leader>bk :bp\|bd! #<CR>
nnoremap <leader>bq :BufOnly <CR>


" Quickfix list manipulation
nnoremap <leader>co :copen<CR>
nnoremap <leader>ck :cclose<CR>
nnoremap <leader>cf :cfirst<CR>
nnoremap <leader>cl :cclast<CR>
nnoremap <C-n> :cprev<CR>
nnoremap <C-m> :cnext<CR>


" Location list manipulation
nnoremap <leader>lo :lopen<CR>
nnoremap <leader>lk :lclose<CR>
nnoremap <leader>n :lprev<CR>
nnoremap <leader>m :lnext<CR>


" Tab manipulation
au TabLeave * let g:lasttab = tabpagenr()
nnoremap <leader>ñ :exe "tabn ".g:lasttab<cr>
nnoremap <leader>tk :tabclose<cr>
nnoremap <leader>tn :tabnew<cr>


" FZF
nnoremap <silent> <leader>ff :Files<CR>
nnoremap <silent> <leader>fg :Rg<CR>
nnoremap <silent> <leader>fb :Buffers<CR>
nnoremap <silent> <leader>fm :Marks<CR>
nnoremap <silent> <leader>fl :BLines<CR>

nnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
inoremap <silent><c-t> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>

" Marks
nnoremap <leader>md :delm!<CR> :delm A-Z0-9<CR>


" Indentation for file types
autocmd FileType html,javascript,typescript,js,ts,jsx,tsx,pug setlocal shiftwidth=2 tabstop=2
autocmd FileType go setlocal shiftwidth=4 tabstop=4

" let g:Illuminate_ftblacklist = ['NvimTree']

" FZF style
let g:fzf_preview_window = []


" When using FZF and Rg, I don't want to include file names
command! -bang -nargs=* Rg
  \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)


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

set laststatus=2
set statusline=
set statusline+=%1*
" set statusline+=\ 
" set statusline+=%{StatuslineMode()}
set statusline+=\ 
set statusline+=%2*
set statusline+=\ 
set statusline+=%3*
set statusline+=%=
set statusline+=%4*
set statusline+=\ 
set statusline+=\ 
set statusline+=
set statusline+=\ 
set statusline+=%f
set statusline+=\ 
set statusline+=%m
set statusline+=\ 
set statusline+=%h
set statusline+=\ 
set statusline+=%r
set statusline+=\ 
set statusline+=%=
set statusline+=\ 
set statusline+=%5*
set statusline+=%l
set statusline+=/
set statusline+=%L
set statusline+=\ 
set statusline+=%6*
set statusline+=\[%{&fileformat}\]
set statusline+=|
set statusline+=%y

" hi User1 guibg=gray69 guifg=black gui=bold

" function! StatuslineMode()
"   let l:mode=mode()
"   if l:mode==#"n"
"     return "NORMAL"
"   elseif l:mode==?"no"
"     return "N OPERATOR PENDING"
"   elseif l:mode==?"nov"
"     return "N OPERATOR BLOCK"
"   elseif l:mode==?"noV"
"     return "N OPERATOR LINE"
"   elseif l:mode==?"V"
"     return "V LINE"
"   elseif l:mode==?"v"
"     return "VISUAL"
"   elseif l:mode==?""
"     return "V BLOCK"
"   elseif l:mode==#"i"
"     return "INSERT"
"   elseif l:mode==#"R"
"     return "REPLACE"
"   elseif l:mode==#"Rv"
"     return "V REPLACE"
"   elseif l:mode==#"Rx"
"     return "C REPLACE"
"   elseif l:mode==#"Rc"
"     return "C REPLACE"
"   elseif l:mode==?"s"
"     return "SELECT"
"   elseif l:mode==?"S"
"     return "S LINE"
"   elseif l:mode==?"^S"
"     return "S BLOCK"
"   elseif l:mode==#"t"
"     return "TERMINAL"
"   elseif l:mode==#"c"
"     return "COMMAND"
"   elseif l:mode==#"cv"
"     return "VIM EX"
"   elseif l:mode==#"ce"
"     return "EX"
"   elseif l:mode==#"r"
"     return "PROMPT"
"   elseif l:mode==#"rm"
"     return "MORE"
"   elseif l:mode==#"r?"
"     return "CONFIRM"
"   elseif l:mode==#"!"
"     return "SHELL"
"   endif
" endfunction

let g:netrw_keepdir = 0
let g:netrw_winsize = 20
let g:netrw_banner = 0
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_liststyle = 3

nnoremap <leader>dd :Lexplore %:p:h<CR> " Directory of current file
nnoremap <Leader>da :Lexplore<CR> " Current working directory

function! NetrwMapping()
  nmap <buffer> H u " Go back in history
  nmap <buffer> h -^ " Go up directory
  nmap <buffer> l <CR> " Open a file or directory

  nmap <buffer> . gh " Toggle dotfiles
  nmap <buffer> P <C-w>z " Close preview window
  "

  nmap <buffer> L <CR>:Lexplore<CR> " Open a file and close netrw
  nmap <buffer> <Leader>dd :Lexplore<CR> " Close netrw
endfunction

augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

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


lua <<EOF
require('lsp')
require('treesitter')
require('utils')
require('statusline')
EOF
