syntax on
filetype plugin indent on

set path+=**
set signcolumn=yes
set smartindent
set tabstop=2
set softtabstop=2
set shiftwidth=2
set expandtab
set nobackup
set noswapfile
set scrolloff=7
set completeopt=menu,noinsert,noselect
set mouse=a
set spellsuggest=best,9
set wildignore+=*.png,*.jpg,*jpg,*/.git/*,*/node_modules/*
set nowrap
set termguicolors
set pumblend=15
set number

" ................................................................................
" Plugins

call plug#begin('~/.local/share/nvim/plugged')
Plug 'neovim/nvim-lspconfig'                                  " Config for each lsp
Plug 'hrsh7th/cmp-nvim-lsp'                                   " Completion
Plug 'hrsh7th/cmp-buffer'                                     " Buffer completion
Plug 'hrsh7th/cmp-path'                                       " Path completion
Plug 'hrsh7th/nvim-cmp'                                       " More completion...
Plug 'hrsh7th/cmp-nvim-lsp-signature-help'                    " Show signature
Plug 'williamboman/nvim-lsp-installer'                        " lsp manager/installer

Plug 'norcalli/nvim-colorizer.lua'                            " Show colors #HEX 
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}   " AST
Plug 'numToStr/Comment.nvim'                                  " Easy comments
Plug 'akinsho/bufferline.nvim', { 'tag': 'v2.*' }
Plug 'mattn/emmet-vim'                                        " Web stuff
Plug 'mbbill/undotree'                                        " Visual undotree
Plug 'gpanders/editorconfig.nvim'                             " Sane configs per project
Plug 'danymat/neogen'                                         " Generate doc
Plug 'tpope/vim-fugitive'                                     " Git
Plug 'L3MON4D3/LuaSnip'                                       " Snippets
Plug 'sbdchd/neoformat'                                       " Formatter manager
Plug 'windwp/nvim-ts-autotag'                                 " Manipulate tags
Plug 'romgrk/nvim-treesitter-context'                         " Context under cursor
Plug 'godlygeek/tabular'                                      " Old school tab
Plug 'AndrewRadev/splitjoin.vim'                               " Easy split
Plug 'ibhagwan/fzf-lua', {'branch': 'main'}                   " Search
call plug#end()

" ................................................................................
" Mappings (Not all the mappings are located here...)

let mapleader=" "
:imap jk <Esc>
nnoremap <leader>s :w<cr>
nnoremap <leader>qq :q<cr>
nnoremap <silent> <F2> :set spell!<cr>
inoremap <silent> <F2> <C-O>:set spell!<cr>
nnoremap <leader>fd :find 
nnoremap <leader>rg :Rgrep 

:tnoremap fd <C-\><C-n>
vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

noremap <Up>    :resize +2<CR>
nnoremap <Down>  :resize -2<CR>
nnoremap <Left>  :vertical resize +2<CR>
nnoremap <Right> :vertical resize -2<CR>

command! BufOnly execute '%bdelete|edit #|normal `"'
nnoremap <leader>bq :BufOnly <CR>
nnoremap <leader><leader> <c-^>
nnoremap <leader>, :ls<cr>:b<space>
nnoremap <leader>bk :bp\|bd! #<CR>

nnoremap <leader>co :copen<CR>
nnoremap <leader>ck :cclose<CR>
nnoremap <leader>cf :cfirst<CR>
nnoremap <leader>cl :cclast<CR>
nnoremap <leader>cn :cnext<CR>
nnoremap <leader>cp :cprevious<CR>

nnoremap <leader>lo :lopen<CR>
nnoremap <leader>lk :lclose<CR>
nnoremap <leader>ln :lnext<CR>
nnoremap <leader>lp :lprevious<CR>

nnoremap <F8> :UndotreeToggle<CR>

au TabLeave * let g:lasttab = tabpagenr()
nnoremap <leader>ñ :exe "tabn ".g:lasttab<cr>
nnoremap <leader>tk :tabclose<cr>
nnoremap <leader>tn :tabnew<cr>

nnoremap <silent><c-t> <Cmd>exe v:count1 . "ToggleTerm"<CR>
inoremap <silent><c-t> <Esc><Cmd>exe v:count1 . "ToggleTerm"<CR>

nnoremap <leader>md :delm!<CR> :delm A-Z0-9<CR>

nnoremap <leader>vu gggqG
nnoremap <leader>vc :make % \| cwindow<CR>

" ................................................................................
" Other global stuff

colorscheme tempus-tempest

if executable("rg")
    set grepprg=rg\ --vimgrep\ --smart-case\ --hidden
    set grepformat=%f:%l:%c:%m
endif

autocmd FileType html,javascript,typescript,js,ts,jsx,tsx,pug,javascriptreact,typescriptreact 
      \ setlocal shiftwidth=2 tabstop=2
autocmd BufWinEnter,WinEnter *.svelte set syntax=html
autocmd FileType cpp,go,java,lua setlocal shiftwidth=4 tabstop=4
autocmd FileType html, javascript,typescript,js,ts,jsx,tsx EmmetInstall
autocmd BufWritePre *.go lua OrgImports(1000)
autocmd FileType go setlocal omnifunc=v:lua.vim.lsp.omnifunc

set errorformat+=%f:\ line\ %l\\,\ col\ %c\\,\ %m,%-G%.%#

" https://stackoverflow.com/questions/10692289/proper-html-attribute-highlighting-in-vim thanks!
function! SynStack()
    if !exists("*synstack")
        return
    endif
    echo map(synstack(line('.'), col('.')), 'synIDattr(v:val, "name")')
endfunc

" ................................................................................
" QuickFix specific stuuf
" Rgrep: grep + quickfix list. Source: https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3
" quickfix: Don't show the preview after grep
" https://vim.fandom.com/wiki/Search_for_current_word_in_multiple_files
" searches for the text in the word under the cursor (like g*) in any of the files in the current directory. 
" searches for the text in the word under the cursor (like g*) in any of the files in the same directory as the current file
" searches for the whole word under the cursor (like *) in any of the files in the current directory
" searches for the whole word under the cursor (like *) in any of the files in the same directory as the current file. 

function! Rgrep(...)
    return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
endfunction

command! -nargs=+ -complete=file_in_path -bar Rgrep  cgetexpr Rgrep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LRgrep lgetexpr Rgrep(<f-args>)

augroup quickfix
    autocmd!
    autocmd QuickFixCmdPost cgetexpr cwindow
    autocmd QuickFixCmdPost lgetexpr lwindow
augroup END

:nnoremap ñ :Rgrep <cword>*<CR>
:nnoremap <leader>ñ :Rgrep <cword>%:p:h/*<CR>
:nnoremap ç :Rgrep '\b<cword>\b'*<CR>
:nnoremap <leader>ç :Rgrep '\b<cword>\b'%:p:h/*<CR>

" ................................................................................
" Netrw configuration based on 
" https://vonheikemen.github.io/devlog/tools/using-netrw-vim-builtin-file-explorer/
" Some mappings
" https://gist.github.com/danidiaz/37a69305e2ed3319bfff9631175c5d0f 
" Some interesting keymaps:
" R -> Rename a file
" mc -> Copy marked files
" mm -> Move marked files
" mx -> Run external commands on marked files
" mb -> Create a bookmark
" mB -> Remove the most recent bookmark
" gb -> Jump to the most recent bookmark

let g:netrw_keepdir = 0
let g:netrw_banner = 0 
let g:netrw_list_hide = '\(^\|\s\s\)\zs\.\S\+'
let g:netrw_localcopydircmd = 'cp -r'
hi! link netrwMarkFile Search

nnoremap <leader>dd :Explore %:p:h<CR>                                       " Directory of the current file
nnoremap <Leader>da :Explore<CR>                                             " Current working directory

function! NetrwMapping()
    nmap <buffer> . gh                                                        " Toggle dotfiles
    nmap <buffer> P <C-w>z                                                    " Close preview

    nmap <buffer> L <CR>:Explore<CR>                                         " Open a file and close preview
    nmap <buffer> <Leader>dd :Explore<CR>                                    " Close netrw

    nmap <buffer> <TAB> mf                                                    " Toggle the mark in a directory/file
    nmap <buffer> <S-TAB> mF                                                  " Unmark all the files in the current buffer
    nmap <buffer> <Leader><TAB> mu                                            " Remove all the marks in all files

    nmap <buffer> ff %:w<CR>:buffer #<CR>                                     " Create file
    nmap <buffer> fc mtmc                                                     " Assign an copy (for directories)
    nmap <buffer> fx mtmm                                                     " Same as fC but for moving files

    nmap <buffer> fl :echo join(netrw#Expose("netrwmarkfilelist"), "\n")<CR>  " Show marked files
    nmap <buffer> fq :echo 'Target:' . netrw#Expose("netrwmftgt")<CR>         " Show target directory

    nmap <buffer> FF :call NetrwRemoveRecursive()<CR>
endfunction

function! NetrwRemoveRecursive()
    if &filetype ==# 'netrw'
      cnoremap <buffer> <CR> rm -r<CR>
      normal mu
      normal mf
      
      try
        normal mx
      catch
        echo "Canceled"
      endtry

      cunmap <buffer> <CR>
    endif
  endfunction

augroup netrw_mapping
  autocmd!
  autocmd filetype netrw call NetrwMapping()
augroup END

" ................................................................................
" Terminal usage

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

" ................................................................................
" Disabling some built in plugins

let g:loaded_matchparen = 1
let g:loaded_matchit = 1
let g:loaded_2html_plugin = 1
let g:loaded_getscriptPlugin = 1
let g:loaded_gzip = 1
let g:loaded_logipat = 1
let g:loaded_rrhelper = 1
let g:loaded_spellfile_plugin = 1
let g:loaded_tarPlugin = 1
let g:loaded_vimballPlugin = 1
let g:loaded_zipPlugin = 1

" ................................................................................
" Lua files

lua <<EOF
require('lsp')          -- LSP native configuration
require('plugins')      -- Configuratoin of Lua plugins
require('snippets')     -- Snippets configuration
require('statusline')   -- Custom status line
EOF

