 "  _____  _             _           
 " |  __ \| |           (_)          
 " | |__) | |_   _  __ _ _ _ __  ___ 
 " |  ___/| | | | |/ _` | | '_ \/ __|
 " | |    | | |_| | (_| | | | | \__ \
 " |_|    |_|\__,_|\__, |_|_| |_|___/
 "                  __/ |            
 "                 |___/             

call plug#begin('~/.local/share/nvim/plugged')

" SYNTAX HIGHLIGHT AND THEME 
Plug 'norcalli/nvim-colorizer.lua'
Plug 'sheerun/vim-polyglot'
Plug 'gruvbox-community/gruvbox'

" USABILITY
Plug 'jiangmiao/auto-pairs'
Plug 'prettier/vim-prettier', {'do':'npm install'}
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-commentary'
Plug 'itchyny/lightline.vim'

" SEARCH
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'

" INTELLISENSE AND ANALYSIS
Plug 'neoclide/coc.nvim',{'branch' : 'release'}

call plug#end()

let g:polyglot_disabled = ['coffe-script', 'vue']

"  _____                                  _       __            _ _   
" |  __ \                                | |     / _|          | | |  
" | |__) |___ _ __ ___   __ _ _ __     __| | ___| |_ __ _ _   _| | |_ 
" |  _  // _ \ '_ ` _ \ / _` | '_ \   / _` |/ _ \  _/ _` | | | | | __|
" | | \ \  __/ | | | | | (_| | |_) | | (_| |  __/ || (_| | |_| | | |_ 
" |_|  \_\___|_| |_| |_|\__,_| .__/   \__,_|\___|_| \__,_|\__,_|_|\__|
"                            | |                                      
"                            |_|                                      

:imap jk <Esc>
let mapleader=" "
nnoremap zz :update<cr>
inoremap zz <Esc>:update<cr>i
nnoremap qq :q<cr>
:tnoremap jk <C-\><C-n>
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
nnoremap <A-h> gT
nnoremap <A-l> gt
tnoremap <A-h> gT
tnoremap <A-l> gt
nnoremap <S-TAB> :bprev<CR>
nnoremap <TAB> :bnext<CR>
nnoremap <Leader>x <C-W>s
nnoremap <Leader>v <C-W>v
nnoremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv
nnoremap <Leader>n :e<space>
nnoremap <Leader>z :tabnew term://zsh<CR>i
nnoremap <Leader>k :bp\|bd! #<CR>
nnoremap <Leader>K :bufdo bd<CR>
nnoremap <Leader>b :belowright split term://zsh<CR>i
nnoremap <Leader>B :te zsh<CR>i


"   _____                           _    ____        _   _                 
"  / ____|                         | |  / __ \      | | (_)                
" | |  __  ___ _ __   ___ _ __ __ _| | | |  | |_ __ | |_ _  ___  _ __  ___ 
" | | |_ |/ _ \ '_ \ / _ \ '__/ _` | | | |  | | '_ \| __| |/ _ \| '_ \/ __|
" | |__| |  __/ | | |  __/ | | (_| | | | |__| | |_) | |_| | (_) | | | \__ \
"  \_____|\___|_| |_|\___|_|  \__,_|_|  \____/| .__/ \__|_|\___/|_| |_|___/
"                                             | |                          
"                                             |_|                          

set title
set mouse=a
set termguicolors
set relativenumber
set noshowmode
syntax on
au TermOpen * setlocal nonumber norelativenumber
set hidden
set smartindent
set nowrap
set incsearch
set expandtab
set softtabstop=2
set tabstop=2
set shiftwidth=2
set number
autocmd Filetype java setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd Filetype python setlocal shiftwidth=4 softtabstop=4 expandtab
autocmd Filetype cpp setlocal shiftwidth=4 softtabstop=4 expandtab
set nohlsearch
set nowritebackup
set nobackup
set shortmess+=c
set updatetime=300
set background=dark


"  _______ _                         
" |__   __| |                        
"    | |  | |__   ___ _ __ ___   ___ 
"    | |  | '_ \ / _ \ '_ ` _ \ / _ \
"    | |  | | | |  __/ | | | | |  __/
"    |_|  |_| |_|\___|_| |_| |_|\___|
                                  
colorscheme gruvbox
let g:gruvbox_contrast_dark='hard'


"  _____          _   _   _           
" |  __ \        | | | | (_)          
" | |__) | __ ___| |_| |_ _  ___ _ __ 
" |  ___/ '__/ _ \ __| __| |/ _ \ '__|
" | |   | | |  __/ |_| |_| |  __/ |   
" |_|   |_|  \___|\__|\__|_|\___|_|   
                                 
let g:prettier#autoformat=1
let g:prettier#autoformat_require_pragma=0
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
let g:prettier#exec_cmd_async=1
let g:prettier#config#parser=''
let g:prettier#config#use_tabs='false'
let g:prettier#config#tab_width='2'


"  ______    __ 
" |  ____|  / _|
" | |__ ___| |_ 
" |  __|_  /  _|
" | |   / /| |  
" |_|  /___|_|  

nnoremap <Leader>F :Files<CR>
noremap <Leader>s :Rg<CR>
noremap <Leader>S :exe ':Rg ' . expand('<cword>')<CR>
nnoremap ç :Buffers<CR>
nnoremap <Leader>h :History<CR>
nnoremap <Leader>f :GFiles<CR>
nnoremap <Leader>u :GFiles?<CR>
nnoremap <Leader>l :Lines<CR>
nnoremap <Leader>L :BLines<CR>
nnoremap <Leader>t :Tags<CR>
nnoremap <Leader>T :BTags<CR>
nnoremap <Leader>m :Marks<CR>
nnoremap <Leader>o :Commands<CR>
nnoremap <Leader>c :Commits<CR>
nnoremap <Leader>C :BCommits<CR>
nnoremap <Leader>M :Maps<CR>


"   _____      _            _             _ 
"  / ____|    | |          (_)           | |
" | |     ___ | | ___  _ __ _ _______  __| |
" | |    / _ \| |/ _ \| '__| |_  / _ \/ _` |
" | |___| (_) | | (_) | |  | |/ /  __/ (_| |
"  \_____\___/|_|\___/|_|  |_/___\___|\__,_|

lua require'colorizer'.setup()


"  ______                          _   
" |  ____|                        | |  
" | |__   _ __ ___  _ __ ___   ___| |_ 
" |  __| | '_ ` _ \| '_ ` _ \ / _ \ __|
" | |____| | | | | | | | | | |  __/ |_ 
" |______|_| |_| |_|_| |_| |_|\___|\__|
                                    
autocmd FileType html EmmetInstall


"  _   _              _ _______ _____  ______ ______ 
" | \ | |            | |__   __|  __ \|  ____|  ____|
" |  \| | ___ _ __ __| |  | |  | |__) | |__  | |__   
" | . ` |/ _ \ '__/ _` |  | |  |  _  /|  __| |  __|  
" | |\  |  __/ | | (_| |  | |  | | \ \| |____| |____ 
" |_| \_|\___|_|  \__,_|  |_|  |_|  \_\______|______|

map <F2> :NERDTreeToggle<CR>

                                                    
"   _____       _____ 
"  / ____|     / ____|
" | |     ___ | |     
" | |    / _ \| |     
" | |___| (_) | |____ 
"  \_____\___/ \_____|

if has("patch-8.1.1564")
  set signcolumn=2
else
  set signcolumn=yes
endif

inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Trigger completion
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Go to definition
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" To navigate diagnostics
nmap <silent> <C-n> <Plug>(coc-diagnostic-prev)
nmap <silent> <C-m> <Plug>(coc-diagnostic-next)

" Show documentation
nnoremap <silent> K :call <SID>show_documentation()<CR>

" Symbol rename
nmap <leader>rn <Plug>(coc-rename)

" Applying codeaction to the selected region
xmap <leader>as  <Plug>(coc-codeaction-selected)
nmap <leader>as  <Plug>(coc-codeaction-selected)

" Aplying codeaction to the current buffer
nmap <leader>ac  <Plug>(coc-codeaction)
nmap <leader>qf  <Plug>(coc-fix-current)

" Show documentation
function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

let g:lightline = {
      \ 'colorscheme': 'seoul256',
      \}
