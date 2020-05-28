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
Plug 'posva/vim-vue'
Plug 'norcalli/nvim-colorizer.lua'
Plug 'morhetz/gruvbox'

" USABILITY
Plug 'itchyny/lightline.vim'
Plug 'tpope/vim-commentary'
Plug 'jiangmiao/auto-pairs'
Plug 'prettier/vim-prettier', {'do':'npm install'}
Plug 'mhinz/vim-startify'

" SEARCH
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'

" INTELLISENSE AND ANALYSIS
Plug 'neoclide/coc.nvim',{'branch' : 'release'}

call plug#end()


 "  _____                                  _       __            _ _   
 " |  __ \                                | |     / _|          | | |  
 " | |__) |___ _ __ ___   __ _ _ __     __| | ___| |_ __ _ _   _| | |_ 
 " |  _  // _ \ '_ ` _ \ / _` | '_ \   / _` |/ _ \  _/ _` | | | | | __|
 " | | \ \  __/ | | | | | (_| | |_) | | (_| |  __/ || (_| | |_| | | |_ 
 " |_|  \_\___|_| |_| |_|\__,_| .__/   \__,_|\___|_| \__,_|\__,_|_|\__|
 "                            | |                                      
 "                            |_|                                      

:imap jj <Esc>
let mapleader=" "
nnoremap zz :update<cr>
inoremap zz <Esc>:update<cr>i
nnoremap qq :q<cr>
:tnoremap jj <C-\><C-n>
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


 "  _______ _                         
 " |__   __| |                        
 "    | |  | |__   ___ _ __ ___   ___ 
 "    | |  | '_ \ / _ \ '_ ` _ \ / _ \
 "    | |  | | | |  __/ | | | | |  __/
 "    |_|  |_| |_|\___|_| |_| |_|\___|
                                    
autocmd VimEnter * colorscheme gruvbox
set background=dark


 "  _      _       _     _   _ _            
 " | |    (_)     | |   | | | (_)           
 " | |     _  __ _| |__ | |_| |_ _ __   ___ 
 " | |    | |/ _` | '_ \| __| | | '_ \ / _ \
 " | |____| | (_| | | | | |_| | | | | |  __/
 " |______|_|\__, |_| |_|\__|_|_|_| |_|\___|
 "            __/ |                         
 "           |___/                          

let g:lightline = { 'colorscheme': 'seoul256' }


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
let g:prettier#config#config_precedence='file-override'
let g:prettier#config#use_tabs='false'
let g:prettier#config#tab_width='1'


 "  ______    __ 
 " |  ____|  / _|
 " | |__ ___| |_ 
 " |  __|_  /  _|
 " | |   / /| |  
 " |_|  /___|_|  

nnoremap <Leader>F :Files<CR>
nnoremap <Leader>g :Rg<CR>
noremap <Leader>s :Ag<CR>
noremap <Leader>S :exe ':Ag ' . expand('<cword>')<CR>
nnoremap , :Buffers<CR>
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
nnoremap <Leader>b :tabnew term://zsh<CR>i
nnoremap <Leader>n :e<space>
nnoremap <Leader>k :bd!<CR>
nnoremap <Leader>K :bufdo bd<CR>
nnoremap <Leader>B :sp term://zsh<CR>i
nnoremap <Leader>, :te zsh<CR>i

 "  _   _              _ _______            
 " | \ | |            | |__   __|           
 " |  \| | ___ _ __ __| |  | |_ __ ___  ___ 
 " | . ` |/ _ \ '__/ _` |  | | '__/ _ \/ _ \
 " | |\  |  __/ | | (_| |  | | | |  __/  __/
 " |_| \_|\___|_|  \__,_|  |_|_|  \___|\___|

map <F2> :NERDTreeToggle<CR>
map <F3> :NERDTreeFind<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


 "   _____ _             _   _  __       
 "  / ____| |           | | (_)/ _|      
 "   (___ | |_ __ _ _ __| |_ _| |_ _   _ 
 "  \___ \| __/ _` | '__| __| |  _| | | |
 "  ____) | || (_| | |  | |_| | | | |_| |
 " |_____/ \__\__,_|_|   \__|_|_|  \__, |
 "                                  __/ |
 "                                 |___/ 

let s:header = [
			\'.######..######...####....####....####...######.',
			\'.##..........##..##......##..........##.....##..',
			\'.####........##...####....####....####.....###..',
			\'.##......##..##......##......##..##..........##.',
			\'.##.......####....####....####...######..#####..']

let g:startify_padding_left=60

function! s:center(lines) abort
  let longest_line   = max(map(copy(a:lines), 'strwidth(v:val)'))
  let centered_lines = map(copy(a:lines),
        \ 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
  return centered_lines
endfunction

let g:startify_custom_header = s:center(s:header)


 "   _____      _            _             _ 
 "  / ____|    | |          (_)           | |
 " | |     ___ | | ___  _ __ _ _______  __| |
 " | |    / _ \| |/ _ \| '__| |_  / _ \/ _` |
 " | |___| (_) | | (_) | |  | |/ /  __/ (_| |
 "  \_____\___/|_|\___/|_|  |_/___\___|\__,_|

lua require'colorizer'.setup()


 "   _____       _____ 
 "  / ____|     / ____|
 " | |     ___ | |     
 " | |    / _ \| |     
 " | |___| (_) | |____ 
 "  \_____\___/ \_____|

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current
" position. Coc only does snippet and additional edit on confirm.
" <cr> could be remapped by other vim plugin, try `:verbose imap <CR>`.
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"
endif

" Use `` and `` to navigate diagnostics
nmap <silent> <C-n> <Plug>(coc-diagnostic-prev) " MODIFIED
nmap <silent> <C-m> <Plug>(coc-diagnostic-next) " MODIFIED

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window.
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
" xmap <leader>f  <Plug>(coc-format-selected)
" nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of LS, ex: coc-tsserver
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocAction('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -narg=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings using CoCList:
" Show all diagnostics.
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document. MODIFIED
nnoremap <silent> <space>O  :<C-u>CocList outline<cr>
" Search workspace symbols. MODIFIED
nnoremap <silent> <space>y  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item. MODIFIED
nnoremap <silent> <space>p  :<C-u>CocPrev<CR>
" Resume latest coc list. MODIFIED
nnoremap <silent> <space>z  :<C-u>CocListResume<CR>s
