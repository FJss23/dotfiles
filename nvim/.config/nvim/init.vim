let mapleader=' '
let maplocalleader=' '

inoremap qw {
inoremap wq }
inoremap qq [
inoremap ww ]
inoremap jk <Esc>
nnoremap <leader>j <cmd>w<cr>
nnoremap <leader>q <cmd>q<cr>

vnoremap J :m '>+1<CR>gv=gv
vnoremap K :m '<-2<CR>gv=gv

nnoremap <Up> <cmd>resize +2<CR>
nnoremap <Down> <cmd>resize -2<CR>
nnoremap <Left> <cmd>vertical resize +2<CR>
nnoremap <Right> <cmd>vertical resize -2<CR>

nnoremap <leader><leader> <c-^>
nnoremap <leader>, :ls<CR>:b<space>
nnoremap <leader>bk <cmd>bp\|bd! #<CR>

nnoremap <leader>co <cmd>copen<CR>
nnoremap <leader>ck <cmd>cclose<CR>
nnoremap <leader>cn <cmd>cnext<CR>
nnoremap <leader>cp <cmd>cprevious<CR>

nnoremap <leader>lo <cmd>lopen<CR>
nnoremap <leader>lk <cmd>lclose<CR>
nnoremap <leader>ln <cmd>lnext<CR>
nnoremap <leader>lp <cmd>lprevious<CR>

nnoremap <leader>tk <cmd>tabclose<CR>
nnoremap <leader>tn <cmd>tabnew<CR>

nnoremap <leader>sc <cmd>e $MYVIMRC<CR>

nnoremap <silent> <F2> <cmd>set spell!<CR>
inoremap <silent> <F2> <C-O><cmd>set spell!<CR>

set path+=**
set splitright 
set splitbelow 
set cursorline 
set hlsearch 
set mouse=a
set number 
set numberwidth
set breakindent 
set undofile 
set ignorecase 
set smartcase 
set noswapfile 
set scrolloff=7
set spellsuggest=best,9
set spelllang=en_us
set nospell
set updatetime=250
set signcolumn=no
set wildignore+=*.png,*.jpg,*/.git/*,*/node_modules/*,*/tmp/*,*.so,*.zip
set completeopt=menuone,noinsert,noselect
set colorcolumn=90
set shiftwidth=4
set tabstop=4
set expandtab 
set termguicolors 

call plug#begin('~/.local/share/nvim/plugged')
Plug 'https://github.com/neovim/nvim-lspconfig'
Plug 'https://github.com/hrsh7th/nvim-cmp' | Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'https://github.com/nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'https://github.com/hrsh7th/vim-vsnip'
Plug 'https://github.com/junegunn/fzf.vim' | Plug '~/.fzf'
Plug 'https://github.com/ap/vim-css-color'
Plug 'https://github.com/tpope/vim-commentary'
Plug 'https://github.com/mattn/emmet-vim'
Plug 'https://github.com/obaland/vfiler.vim'
Plug 'https://github.com/mattn/emmet-vim'
Plug 'https://github.com/dracula/vim'
call plug#end()

colorscheme dracula

let g:loaded_netrw = 1
let g:loaded_netrwPlugin = 1
let g:loaded_netrwSettings = 1
let g:loaded_netrwFileHandlers = 1

nnoremap <leader>da :VFiler -auto-resize -keep -layout=left -name=explorer -width=30 -columns=indent,name<CR>

let g:user_emmet_install_global = 0

autocmd FileType html,css,javascript,javascriptreact,typescript,typescriptreact EmmetInstall

let g:user_emmet_settings = {
\  'javascript' : {
\      'extends' : 'jsx',
\  },
\  'typescript' : {
\      'extends' : 'jsx',
\  },
\  'javascript.jsx' : {
\    'extends' : 'jsx',
\    'default_attributes': {
\      'label': [{'htmlFor': ''}],
\    }
\  },
\}

hi! link DiagnosticLineNrError DiagnosticError
hi! link DiagnosticLineNrWarn DiagnosticWarn
hi! link DiagnosticLineNrInfo DiagnosticInfo
hi! link DiagnosticLineNrHint DiagnosticHint

highlight! DiagnosticLineNrError guibg=#51202A guifg=#FF0000 gui=bold
highlight! DiagnosticLineNrWarn guibg=#51412A guifg=#FFA500 gui=bold
highlight! DiagnosticLineNrInfo guibg=#1E535D guifg=#00FFFF gui=bold
highlight! DiagnosticLineNrHint guibg=#1E205D guifg=#0000FF gui=bold

sign define DiagnosticSignError text= texthl=DiagnosticSignError linehl= numhl=DiagnosticLineNrError
sign define DiagnosticSignWarn text= texthl=DiagnosticSignWarn linehl= numhl=DiagnosticLineNrWarn
sign define DiagnosticSignInfo text= texthl=DiagnosticSignInfo linehl= numhl=DiagnosticLineNrInfo
sign define DiagnosticSignHint text= texthl=DiagnosticSignHint linehl= numhl=DiagnosticLineNrHint

autocmd FileType markdown,txt,tex,gitcommit setlocal spell

lua <<EOF
-- Treesitter {{{
require('nvim-treesitter.configs').setup {
    ensure_installed = { 
        'javascript', 
        'jsdoc', 
        'typescript', 
        'tsx', 
        'astro',
        'help', 
        'css', 
        'scss'
    },
    highlight = { enable = true },
    indent = { enable = true },
}
--}}}

local cmp = require 'cmp'
local home = os.getenv('HOME')
local api = vim.api
local keymap = vim.keymap

-- Cmp {{{
cmp.setup {
    completion = {
        autocomplete = false
    },
    snippet = {
        expand = function(args)
            vim.fn["vsnip#anonymous"](args.body)
        end,
    },
    formatting = {
        format = function (entry, vim_item)
            vim_item.menu = ({ nvim_lsp = '[LSP]' })[entry.source.name]
            return vim_item
        end
    },
    mapping = cmp.mapping.preset.insert {
        ['<C-b>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<C-e>'] = cmp.mapping.abort(),
        ['<CR>'] = cmp.mapping.confirm { behavior = cmp.ConfirmBehavior.Replace, select = true, },
    },
    sources = {
        { name = 'nvim_lsp' },
        { name = 'vsnip' },
    },
}
--}}}

-- Lsp Config {{{
local function organize_imports()
    vim.lsp.buf.code_action({ context = { only = { "source.organizeImports" } }, apply = true })
end

vim.diagnostic.config({
    virtual_text = false,
    signs = false,
    underline = true,
    update_in_insert = true,
    severity_sort = true,
    float = {
        severity_sort = true,
        source = 'always',
        show_header = true,
        focusable = false,
    }
})

keymap.set('n', 'dp', vim.diagnostic.goto_prev)
keymap.set('n', 'dn', vim.diagnostic.goto_next)
keymap.set('n', '<leader>e', vim.diagnostic.open_float)
keymap.set('n', '<leader>le', vim.diagnostic.setloclist)

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('UserLspConfig', {}),
  callback = function(ev)
    -- Enable completion triggered by <c-x><c-o>
    vim.bo[ev.buf].omnifunc = 'v:lua.vim.lsp.omnifunc'

    -- Buffer local mappings.
    -- See `:help vim.lsp.*` for documentation on any of the below functions
    local opts = { buffer = ev.buf }
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, opts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, opts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, opts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, opts)
    vim.keymap.set('n', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('i', '<C-k>', vim.lsp.buf.signature_help, opts)
    vim.keymap.set('n', '<space>wa', vim.lsp.buf.add_workspace_folder, opts)
    vim.keymap.set('n', '<space>wr', vim.lsp.buf.remove_workspace_folder, opts)
    vim.keymap.set('n', '<space>wl', function()
      print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
    end, opts)
    vim.keymap.set('n', '<space>D', vim.lsp.buf.type_definition, opts)
    vim.keymap.set('n', '<leader>ds', vim.lsp.buf.document_symbol, opts)
    vim.keymap.set('n', '<leader>ws', vim.lsp.buf.workspace_symbol, opts)
    vim.keymap.set('n', '<space>rn', vim.lsp.buf.rename, opts)
    vim.keymap.set('n', '<space>ca', vim.lsp.buf.code_action, opts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, opts)
  end,
})

local formatting_callback = function(client, bufnr)
  vim.keymap.set('n', '<leader>f', function()
    local params = vim.lsp.util.make_formatting_params({})
    client.request('textDocument/formatting', params, nil, bufnr) 
  end, {buffer = bufnr})
end

local servers = { 
    'tsserver', 
    'cssls', 
    'cssmodules_ls', 
    'astro',
    'bashls',
    'pylsp',
    'cmake',
    'clangd',
    'dockerls',
    'prismals'
}

local lspconfig = require('lspconfig')
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

for _, lsp in ipairs(servers) do
    lspconfig[lsp].setup {
        capabilities = capabilities,
    }
end
--}}}

-- Yaml {{{
lspconfig.yamlls.setup {
    settings = {
    yaml = {
        schemaStore = {
            url = "https://www.schemastore.org/api/json/catalog.json",
            enable = true,
        }
      }
    },
    capabilities = capabilities
}
--}}}

-- Javascript / Typescript {{{
lspconfig.tsserver.setup({
    capabilities = capabilities,
    commands = {
        OrganizeImports = {
            organize_imports,
            description = 'Orginze js and ts imports'
        }
    }
})

--lspconfig.eslint.setup({
 --   capabilities = capabilities,
  --  settings = {
   --     codeActionOnSave = {
    --        enable = true,
     --       mode = "all"
    --    },
   -- }
--})
--}}}

-- Go {{{
local go_path_bin = home .. '/.asdf/installs/golang/1.19.5/packages/bin/'

lspconfig.gopls.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        formatting_callback(client, bufnr)
    end,
    cmd = { go_path_bin .. 'gopls', 'serve' },
    settings = {
        gopls = {
            analyses = {
                unusedparams = true,
                shadow = true,
            },
            staticcheck = true,
        }
    },
    commands = {
        OrganizeImports = {
            organize_imports,
            description = 'Orginze go imports'
        }
    }
})

--lspconfig.golangci_lint_ls.setup({
    --capabilities = capabilities,
    --cmd = { go_path_bin .. 'golangci-lint-langserver' },
    --init_options = {
        --command = { go_path_bin .. 'golangci-lint', 'run', '--out-format', 'json' }
    --}
    
--})
--}}}

keymap.set('n', '<leader>o', '<cmd>OrganizeImports<CR>', {silent = true})

-- LaTeX {{{
local texlab_path_bin = home .. '/.config/nvim/lsp-langs/texlab'

lspconfig.texlab.setup({
    capabilities = capabilities,
    cmd = { texlab_path_bin },
})
--}}}

-- Rust {{{
lspconfig.rust_analyzer.setup({
    capabilities = capabilities,
    on_attach = function(client, bufnr)
        formatting_callback(client, bufnr)
    end,
    settings = {
        ["rust-analyzer"] = {
            imports = {
                granularity = {
                    group = "module",
                },
                prefix = "self",
            },
            cargo = {
                buildScripts = {
                    enable = true,
                },
            },
            procMacro = {
                enable = true
            },
            checkOnSave = {
                command = 'clippy'
            }
        }
    }
})
--}}}

-- Efm {{{
lspconfig.efm.setup({
    init_options = {
        documentFormatting = true,
        codeActions = false,
    },
    cmd = { 'efm-langserver', '-c', home .. '/.config/efm-langserver/config.yaml' },
    filetypes = { 
        'javascript', 
        'javascriptreact',
        'typescript',
        'typescriptreact',
        'html',
        'css',
        'scss',
        'yaml',
        'sh',
        'markdown',
        'dockerfile',
        'go'
    },
    on_attach = function(client, bufnr)
        formatting_callback(client, bufnr)
    end,
})
--}}}

-- Status Line {{{
local function branch_name()
	local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
	if branch ~= "" then
		return ' ' .. branch .. " |"
	else
		return ""
	end
end

function status_line() 
    local file = '%f'
    local modifiers = '%m%r%h%w%q'
    local lsp_info = [[%{luaeval("diagnostic_status()")}]]
    local file_type = '%y'
    local line_info = '%l/%L:%c'
    local encoding = '%{&fenc}'
    local file_format = '%{&ff}'

    return table.concat({
        ' %{mode()}', ' | ' ,vim.b.branch_name, ' ', file,' ', modifiers,' ', lsp_info, '%=', encoding, ' ', file_type, ' ', file_format, ' | ', line_info, ' '
    })
end

-- Thanks! https://zignar.net/2022/01/21/a-boring-statusline-for-neovim/
function diagnostic_status()
  local num_errors = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.ERROR })
  if num_errors > 0 then
    return ' E:' .. num_errors .. ' '
  end

  local num_warnings = #vim.diagnostic.get(0, { severity = vim.diagnostic.severity.WARN })
  if num_warnings > 0 then
    return ' W:' .. num_warnings .. ' '
  end
  return ''
end

api.nvim_create_autocmd({"FileType", "BufEnter", "FocusGained"}, {
	callback = function()
		vim.b.branch_name = branch_name()
	end
})
--}}}

local function preview_location_callback(_, result)
  if result == nil or vim.tbl_isempty(result) then
    return nil
  end
  vim.lsp.util.preview_location(result[1])
end

function PeekDefinition()
  local params = vim.lsp.util.make_position_params()
  return vim.lsp.buf_request(0, 'textDocument/definition', params, preview_location_callback)
end

api.nvim_create_autocmd('TextYankPost', {
    group = api.nvim_create_augroup('YankHighlight', { clear = true }),
    callback = function()
        vim.highlight.on_yank()
    end,
    pattern = '*',
})

EOF

nnoremap <leader>p <cmd>lua PeekDefinition()<CR>

set statusline=%!v:lua.status_line()

imap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'
smap <expr> <C-j>   vsnip#expandable()  ? '<Plug>(vsnip-expand)'         : '<C-j>'

let g:fzf_preview_window = []
let g:fzf_layout = { 'window': { 'width': 0.6, 'height': 0.6 } }

nnoremap <leader>sf :Files<CR>
nnoremap <leader>? :History<CR>
nnoremap <leader>sb :Buffers<CR>
nnoremap <leader>/ :Lines<CR>
nnoremap <leader>sh :Helptags<CR>
nnoremap <leader>sg :Rg<CR>

imap <c-x><c-k> <plug>(fzf-complete-word)
imap <c-x><c-f> <plug>(fzf-complete-path)

" https://gist.github.com/romainl/56f0c28ef953ffc157f36cc495947ab3
if executable('rg')
  set grepprg=rg\ -H\ --no-heading\ --vimgrep
  set grepformat=%f:%l:%c:%m
endif

function! Grep(...)
	return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
endfunction

command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr Grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr Grep(<f-args>)

cnoreabbrev <expr> grep  (getcmdtype() ==# ':' && getcmdline() ==# 'grep')  ? 'Grep'  : 'grep'
cnoreabbrev <expr> lgrep (getcmdtype() ==# ':' && getcmdline() ==# 'lgrep') ? 'LGrep' : 'lgrep'

augroup quickfix
	autocmd!
	autocmd QuickFixCmdPost cgetexpr cwindow
	autocmd QuickFixCmdPost lgetexpr lwindow
augroup END

nnoremap rw :Grep<space><c-r><c-w><CR>
