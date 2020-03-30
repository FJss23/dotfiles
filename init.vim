call plug#begin('~/.local/share/nvim/plugged')

" SYNTAX HIGHLIGHT AND THEME 
Plug 'posva/vim-vue'
Plug 'kaicataldo/material.vim'

" USABILITY
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'mattn/emmet-vim'
Plug 'prettier/vim-prettier', {'do':'npm install'}

" SEARCH
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
" Plug 'preservim/nerdtree'

" INTELLISENSE AND ANALYSIS
" Plug 'dense-analysis/ale'
call plug#end()



" Remap
:imap jj <Esc>
map <Space> <Leader>
" Save files
nnoremap zz :update<cr>
inoremap zz <Esc>:update<cr>gi
" Jump one character
inoremap <Tab>e <Esc>ea
" Exit
nnoremap qq :q<cr>
" Move lines
nnoremap <A-j> :m .+1<CR>== nnoremap <A-k> :m .-2<CR>==
inoremap <A-j> <Esc>:m .+1<CR>==gi
inoremap <A-k> <Esc>:m .-2<CR>==gi
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv
" Move between splited viewports
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-h> <C-w>h
nnoremap <C-l> <C-w>l
" Exit terminal mode
:tnoremap jj <C-\><C-n>
" Move between tabs
nnoremap th gT
nnoremap tl gt
" Move between buffers
nnoremap H :bprev<CR>
nnoremap L :bnext<CR>
" Move to the end of the line
nnoremap f $
vnoremap f $
" Move to the beginning of the line
nnoremap 0 _
vnoremap 0 _
" Move to the beginning of the line and inser mode
nnoremap <Leader>0 _i



" Show the name of the current file in the top of the window
set title
" Mouse integration
set mouse=a
" True color on terminal
set termguicolors
" Line number in file
set number
" Eliminate the visualization of the active mode
set noshowmode		 				
" Activate the syntaxis color
syntax on
" Activate the color scheme
colorscheme material					
" Degine the theme for the airline
let g:lightline = { 'colorscheme': 'material_vim' }
" Deactivate option when save
let g:prettier#autoformat = 0				
" Deactivate option when save
let g:prettier#autoformat_require_pragma = 0
" Extensions files that will format
autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue,*.yaml,*.html PrettierAsync
" Hide line numbers on terminal mode
au TermOpen * setlocal nonumber norelativenumber
" Hide buffer unless explicity delete them
:set hidden



" Search a file 
nnoremap <Leader>f :Files<CR>
" Search word in current file
nnoremap <Leader>r :Rg<CR>
" List buffers
nnoremap <Leader>b :Buffers<CR>
" List of history search
nnoremap <Leader>h :History<CR>
" Files under a git project
nnoremap <Leader>g :GFiles<CR>
" Files under a git project unstaged 
nnoremap <Leader>s :GFiles?<CR>
" Lines in loaded buffers
nnoremap <Leader>l :Lines<CR>
" Lines under the current buffer
nnoremap <Leader>c :BLines<CR>
" Tags in the project
nnoremap <Leader>ta :Tags<CR>
" Tags in the current buffer
nnoremap <Leader>n :BTags<CR>
" Marks
nnoremap <Leader>m :Marks<CR>
" Open a new terminal
nnoremap <Leader>ct :term zsh<CR>i
" Open a zsh terminal
nnoremap <Leader>cp :sp term://zsh<CR>i
" Edit a new file
nnoremap <Leader>e :e<Space>
" Close the current buffer 
nnoremap <Leader>db :bd!<CR>
" Close buffer //TODO: set a number 
nnoremap <Leader>dn :bd<Space>
" Deletes all buffers stop at first error
nnoremap <Leader>da :bufdo bd<CR>
