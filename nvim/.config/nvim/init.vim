call plug#begin('~/.local/share/nvim/plugged')

" Lsp
Plug 'neovim/nvim-lspconfig' " Native lsp
Plug 'hrsh7th/cmp-nvim-lsp' " Better lsp experience
Plug 'hrsh7th/cmp-buffer' " Source for buffer words
Plug 'hrsh7th/cmp-path' " Source for fylesystem paths
Plug 'hrsh7th/nvim-cmp' " Completion engine

" Colors
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'} " Syntax highlight
Plug 'Mofiqul/vscode.nvim' " Colorscheme
Plug 'norcalli/nvim-colorizer.lua' " Show colors

" Utils
Plug 'tpope/vim-commentary' " Better comments
Plug 'mattn/emmet-vim' " Better html
Plug 'windwp/nvim-ts-autotag' " Modify tag easily
Plug 'lukas-reineke/indent-blankline.nvim' " Indent lines
Plug 'windwp/nvim-autopairs'
Plug 'p00f/nvim-ts-rainbow' " Colored characters
Plug 'kyazdani42/nvim-web-devicons' " Icons

" Git
Plug 'nvim-lua/plenary.nvim' " Required for gitsigns
Plug 'lewis6991/gitsigns.nvim' " Git info while editing

" Snippets
Plug 'L3MON4D3/LuaSnip' " Snippets superpower
Plug 'saadparwaiz1/cmp_luasnip' " Required for luasnip

" Search
Plug 'kyazdani42/nvim-tree.lua'  " Better file explorer
Plug 'nvim-telescope/telescope.nvim' " Search superpower
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }
" Plug 'junegunn/fzf.vim' " Search superpower

call plug#end()


" Options
set path+=**
set signcolumn=yes
set autoindent
set smartindent
set softtabstop=2 " tabs are 2 spaces
set shiftwidth=2 " >> use 2 spaces
set tabstop=2 " tabs are 2 spaces
set expandtab

" set noexpandtab
" set copyindent
" set preserveindent
" set softtabstop=2 " tabs are 2 spaces
" set shiftwidth=2 " >> use 2 spaces
" set tabstop=2 " tabs are 2 spaces

" set smartindent
" set autoindent
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
" set rtp+=~/.fzf
set wildmenu
set wildmode=longest,list,full
set wildignore+=*.png,*.jpg,*jpg,*/.git/*,*/node_modules/*
" set statusline=\ [\ %{b:git_branch}]\ %<%f\ %h%m%r%=%-14.(%l,%c%V%)\ %P
set nowrap
set colorcolumn=90       
set number relativenumber
" set list lcs=tab:\|\ 
set noshowmode
set cursorline
set background=dark

" let g:gruvbox_material_background='medium'
" let g:gruvbox_material_better_performance = 1
" let g:gruvbox_material_palette='original'
" colorscheme gruvbox-material
let g:vscode_style='dark'
let g:vscode_transparency = 1
let g:vscode_disable_nvimtree_bg = v:true
colorscheme vscode


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
nnoremap <leader>rg :Rg 


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


" Telescope
nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>


" FZF
" nnoremap <silent> <leader>d :Files<CR>
" nnoremap <silent> <leader>fg :Rg<CR>
" nnoremap <silent> <leader>fb :Buffers<CR>
" nnoremap <silent> <leader>fm :Marks<CR>
" nnoremap <silent> <leader>fl :BLines<CR>


" Marks
nnoremap <leader>md :delm!<CR> :delm A-Z0-9<CR>


" Indentation for file types
autocmd FileType html,javascript,typescript,js,ts,jsx,tsx,pug setlocal shiftwidth=2 tabstop=2


" FZF style
" let g:fzf_preview_window = []


" When using FZF and Rg, I don't want to include file names
" command! -bang -nargs=* Rg
"   \ call fzf#vim#grep("rg --column --line-number --no-heading --color=always --smart-case ".shellescape(<q-args>), 1, {'options': '--delimiter : --nth 4..'}, <bang>0)


" New command for FZF. List branches and change
" function! GitCheckoutBranch(branch)
"     let l:name = split(split(trim(a:branch), "", 1)[0], "/", 1)[-1]
"     echo "checking out ".l:name."\n"
"     execute "!git checkout ".l:name
" endfunction

" command! -bang GBranch call fzf#run(fzf#wrap({'source': 'git branch -avv --color', 'sink': function('GitCheckoutBranch'), 'options': '--ansi --nth=1'}, <bang>0))


" Close all buffers except current
command! BufOnly execute '%bdelete|edit #|normal `"'


" Undo tree


" Show current branch on status line
" function Gitbranch()
"     return trim(system("git -C " . expand("%:h") . " branch --show-current 2>/dev/null"))
" endfunction

" augroup Gitget
"     autocmd!
"     autocmd BufEnter * let b:git_branch = Gitbranch()
" augroup END


" grep + quickfix list. Source: https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3
function! Rg(...)
    return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
endfunction

command! -nargs=+ -complete=file_in_path -bar Rg  cgetexpr Rg(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LRg lgetexpr Rg(<f-args>)

augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost cgetexpr cwindow
    autocmd QuickFixCmdPost lgetexpr lwindow
augroup END

set laststatus=2
set statusline=
set statusline+=\ 
set statusline+=%1*
set statusline+=\ 
set statusline+=%{StatuslineMode()}
set statusline+=%2*
set statusline+=\ 
set statusline+=%3*
set statusline+=%{b:gitbranch}
et statusline+=%=
set statusline+=%4*
set statusline+=\ 
set statusline+=%f
set statusline+=\ 
set statusline+=%m
set statusline+=\ 
set statusline+=%h
set statusline+=\ 
set statusline+=%r
set statusline+=\ 
" set statusline+=%4*
" set statusline+=%F
set statusline+=%=
set statusline+=
set statusline+=\ 
set statusline+=%5*
set statusline+=%l
set statusline+=/
set statusline+=%L
set statusline+=\ 
set statusline+=%5*
set statusline+=|
set statusline+=%y
hi StatusLineNC guibg=black guifg=gray
hi StatusLine guibg=gray guifg=snow
hi User1 ctermbg=black ctermfg=white guibg=black guifg=white gui=bold
hi User2 ctermbg=black ctermfg=white guibg=black guifg=white
hi User3 ctermbg=black ctermfg=lightblue guibg=black guifg=lightblue gui=bold
hi User4 ctermbg=black ctermfg=white guibg=black guifg=white
hi User5 ctermbg=black ctermfg=white guibg=black guifg=white

function! StatuslineMode()
  let l:mode=mode()
  if l:mode==#"n"
    return "NORMAL"
  elseif l:mode==?"no"
    return "N OPERATOR PENDING"
  elseif l:mode==?"nov"
    return "N OPERATOR BLOCK"
  elseif l:mode==?"noV"
    return "N OPERATOR LINE"
  elseif l:mode==?"V"
    return "V LINE"
  elseif l:mode==?"v"
    return "VISUAL"
  elseif l:mode==?""
    return "V BLOCK"
  elseif l:mode==#"i"
    return "INSERT"
  elseif l:mode==#"R"
    return "REPLACE"
  elseif l:mode==#"Rv"
    return "V REPLACE"
  elseif l:mode==#"Rx"
    return "C REPLACE"
  elseif l:mode==#"Rc"
    return "C REPLACE"
  elseif l:mode==?"s"
    return "SELECT"
  elseif l:mode==?"S"
    return "S LINE"
  elseif l:mode==?"^S"
    return "S BLOCK"
  elseif l:mode==#"t"
    return "TERMINAL"
  elseif l:mode==#"c"
    return "COMMAND"
  elseif l:mode==#"cv"
    return "VIM EX"
  elseif l:mode==#"ce"
    return "EX"
  elseif l:mode==#"r"
    return "PROMPT"
  elseif l:mode==#"rm"
    return "MORE"
  elseif l:mode==#"r?"
    return "CONFIRM"
  elseif l:mode==#"!"
    return "SHELL"
  endif
endfunction

function! StatuslineGitBranch()
  let b:gitbranch=""
  if &modifiable
    try
      let l:dir=expand('%:p:h')
      let l:gitrevparse = system("git -C ".l:dir." rev-parse --abbrev-ref HEAD")
      if !v:shell_error
        let b:gitbranch="[ ".substitute(l:gitrevparse, '\n', '', 'g')."] "
      endif
    catch
    endtry
  endif
endfunction

augroup GetGitBranch
  autocmd!
  autocmd VimEnter,WinEnter,BufEnter * call StatuslineGitBranch()
augroup END


lua <<EOF
require('lsp')
require('treesitter')
require('utils')
EOF
