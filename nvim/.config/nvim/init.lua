local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'
local is_bootstrap = false

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  is_bootstrap = true
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
  vim.cmd [[packadd packer.nvim]]
end

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim'
  use 'neovim/nvim-lspconfig'
  use { 'hrsh7th/nvim-cmp', requires = { 'hrsh7th/cmp-nvim-lsp', 'dcampos/nvim-snippy' }, }
  use {
    'nvim-treesitter/nvim-treesitter',
    run = function()
      pcall(require('nvim-treesitter.install').update { with_sync = true })
    end,
  }
  use { 'nvim-treesitter/nvim-treesitter-textobjects', after = 'nvim-treesitter' }
  use { 'nvim-tree/nvim-tree.lua' }
  use 'lewpoly/sherbet.nvim'
  use 'nvim-lualine/lualine.nvim'
  use 'tpope/vim-commentary'
  use 'NvChad/nvim-colorizer.lua'
  use 'mattn/emmet-vim'
  use 'editorconfig/editorconfig-vim'
  use 'tpope/vim-surround'
  use 'windwp/nvim-ts-autotag'
  use 'junegunn/fzf.vim'

  if is_bootstrap then
    require('packer').sync()
  end
end)

vim.opt.path:append({'**'})
vim.o.hlsearch = false
vim.wo.number = true
vim.o.mouse = 'a'
vim.o.wrap = false
vim.wo.relativenumber = true
vim.wo.nuw = 2
vim.o.breakindent = true
vim.o.undofile = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.swapfile = false
vim.o.showmode = false
vim.o.scrolloff = 7
vim.opt.spellsuggest = {'best', '9'}
vim.o.updatetime = 250
vim.wo.signcolumn = 'no'
vim.o.termguicolors = true
vim.opt.wildignore:append({'*.png', '*.jpg', '*/.git/*', '*/node_modules/*', '*/tmp/*', '*.so', '*.zip'})
vim.o.completeopt = 'menuone,noselect'
vim.cmd.colorscheme 'sherbet'
vim.g.loaded_netrw = 1
vim.g.loaded_netrwPlugin = 1


local kopts = {silent = true}
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.keymap.set('i', 'qw', '{', kopts)
vim.keymap.set('i', 'wq', '}', kopts)
vim.keymap.set('i', 'qq', '[', kopts)
vim.keymap.set('i', 'ww', ']', kopts)
vim.keymap.set('i', 'jk', '<Esc>', kopts)
vim.keymap.set('n', '<leader>wf', '<cmd>w<cr>', kopts)
vim.keymap.set('n', '<leader>qq', '<cmd>q<cr>', kopts)
vim.keymap.set('n', '<leader>rw', '<cmd>Grep<cword><CR>', kopts)
vim.keymap.set('n', '<leader>rg', ':Grep', kopts)

vim.keymap.set('v', 'J', ":m '>+1<CR>gv=gv", kopts)
vim.keymap.set('v', 'K', ":m '<-2<CR>gv=gv", kopts)

vim.keymap.set('n', '<Up>', '<cmd>resize +2<CR>', kopts)
vim.keymap.set('n', '<Down>', '<cmd>resize -2<CR>', kopts)
vim.keymap.set('n', '<Left>', '<cmd>vertical resize +2<CR>', kopts)
vim.keymap.set('n', '<Right>', '<cmd>vertical resize -2<CR>', kopts)

vim.keymap.set('n', '<leader><leader>', '<c-^>', kopts)
vim.keymap.set('n', '<leader>,', ':ls<CR>:b<space>', kopts)
vim.keymap.set('n', '<leader>bk', [[<cmd>bp\|bd! #<CR>]], kopts)

vim.keymap.set('n', '<leader>co', '<cmd>copen<CR>', kopts)
vim.keymap.set('n', '<leader>ck', '<cmd>cclose<CR>', kopts)
vim.keymap.set('n', '<leader>cn', '<cmd>cnext<CR>', kopts)
vim.keymap.set('n', '<leader>cp', '<cmd>cprevious<CR>', kopts)

vim.keymap.set('n', '<leader>lo', '<cmd>lopen<CR>', kopts)
vim.keymap.set('n', '<leader>lk', '<cmd>lclose<CR>', kopts)
vim.keymap.set('n', '<leader>ln', '<cmd>lnext<CR>', kopts)
vim.keymap.set('n', '<leader>lp', '<cmd>lprevious<CR>', kopts)

vim.keymap.set('n', '<leader>tk', '<cmd>tabclose<CR>', kopts)
vim.keymap.set('n', '<leader>tn', '<cmd>tabnew<CR>', kopts)

vim.keymap.set('n', '<silent> <F2>', '<cmd>set spell!<CR>', kopts)
vim.keymap.set('i', '<silent> <F2>', '<C-O><cmd>set spell!<CR>', kopts)

vim.keymap.set('n', '<leader>sc', '<cmd>e $MYVIMRC<CR>', kopts)
vim.keymap.set('n', '<leader>f', '<cmd>Format<CR>', kopts)

vim.keymap.set('n', '<leader>dd', '<cmd>:NvimTreeToggle<CR>', kopts)
vim.keymap.set('n', '<leader>da', '<cmd>:NvimTreeFindFile<CR>', kopts)


local highlight_group = vim.api.nvim_create_augroup('YankHighlight', { clear = true })
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank()
  end,
  group = highlight_group,
  pattern = '*',
})

require('lualine').setup {
  options = {
    icons_enabled = false,
    component_separators = '|',
    section_separators = '',
  },
  sections = {
    lualine_c = {
      {
        'filename',
        path = 1,
      }
    },
  }
}

require('snippy').setup({
  mappings = {
    is = {
      ['<c-r>'] = 'expand_or_advance',
      ['<c-t>'] = 'previous',
    },
    nx = {
      ['<leader>x'] = 'cut_text',
    },
  },
})

require('colorizer').setup({})

require("nvim-tree").setup({
  view = { side = "right", width = 40 },
  renderer = { 
    icons = { 
      show = { file = false, folder = false },
      git_placement = "after"
    } 
  }
})

require('nvim-treesitter.configs').setup {
  ensure_installed = { 'lua', 'javascript', 'typescript', 'help', 'json', 'html', 'css' },
  highlight = { enable = true },
  indent = { enable = true },
  autotag = { enable = true },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = '<c-space>',
      node_incremental = '<c-space>',
      scope_incremental = '<c-s>',
      node_decremental = '<c-backspace>',
    },
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        ['ça'] = '@function.outer',
        ['çs'] = '@class.outer',
      },
      goto_next_end = {
        ['çd'] = '@function.outer',
        ['çf'] = '@class.outer',
      },
      goto_previous_start = {
        ['çq'] = '@function.outer',
        ['çw'] = '@class.outer',
      },
      goto_previous_end = {
        ['çe'] = '@function.outer',
        ['çr'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}

vim.keymap.set('n', '<leader>?', '<cmd>History<CR>', { desc = '[?] Find recently opened files' })
vim.keymap.set('n', '<leader>sb', '<cmd>Buffers<CR>', { desc = '[ ] Find existing buffers' })
vim.keymap.set('n', '<leader>/', '<cmd>BLines<CR>', { desc = '[/] Fuzzily search in current buffer]' })
vim.keymap.set('n', '<leader>sf', '<cmd>Files<CR>', { desc = '[S]earch [F]iles' })
vim.keymap.set('n', '<leader>sh', '<cmd>Helptags<CR>', { desc = '[S]earch [H]elp' })
vim.keymap.set('n', '<leader>sw', ':Rg ', { desc = '[S]earch current [W]ord' })
vim.keymap.set('n', '<leader>sg', '<cmd>Rg<CR>', { desc = '[S]earch by [G]rep' })

vim.diagnostic.config({
  virtual_text = false,
  signs = true,
  underline = true,
  update_in_insert = true,
  severity_sort = false,
  float = {
    source = 'always',
    show_header = true,
    focusable = false,
  }
})

vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_prev)
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_next)
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float)
vim.keymap.set('n', '<leader>qe', vim.diagnostic.setloclist)

local on_attach = function(_, bufnr)
  local nmap = function(keys, func, desc)
    if desc then
      desc = 'LSP: ' .. desc
    end
    vim.keymap.set('n', keys, func, { buffer = bufnr, desc = desc })
  end

  nmap('<leader>rn', vim.lsp.buf.rename, '[R]e[n]ame')
  nmap('<leader>ca', vim.lsp.buf.code_action, '[C]ode [A]ction')
  nmap('gd', vim.lsp.buf.definition, '[G]oto [D]efinition')
  nmap('gr', vim.lsp.buf.references, '[G]oto [R]eferences')
  nmap('gI', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
  nmap('<leader>D', vim.lsp.buf.type_definition, 'Type [D]efinition')
  nmap('<leader>ds', vim.lsp.buf.document_symbol, '[D]ocument [S]ymbols')
  nmap('<leader>ws', vim.lsp.buf.workspace_symbol, '[W]orkspace [S]ymbols')
  nmap('K', vim.lsp.buf.hover, 'Hover Documentation')
  vim.keymap.set({ 'n', 'i' }, '<C-k>', vim.lsp.buf.signature_help, { buffer = bufnr, desc = 'Signature Documentation' })
  nmap('gD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
  nmap('<leader>wa', vim.lsp.buf.add_workspace_folder, '[W]orkspace [A]dd Folder')
  nmap('<leader>wr', vim.lsp.buf.remove_workspace_folder, '[W]orkspace [R]emove Folder')
  nmap('<leader>wl', function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, '[W]orkspace [L]ist Folders')

  vim.api.nvim_buf_create_user_command(bufnr, 'Format', function(_)
    if vim.lsp.buf.format then
      vim.lsp.buf.format()
    elseif vim.lsp.buf.formatting then
      vim.lsp.buf.formatting()
    end
  end, { desc = 'Format current buffer with LSP' })
end


local servers = { 'tsserver', 'cssls', 'cssmodules_ls' }

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)

for _, lsp in ipairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

local home = os.getenv('HOME')

local prettier = { formatCommand = "prettier --stdin --stdin-filepath ${INPUT}", formatStdin = true }

local languages = {
  typescript = { prettier }, 
  javascript = { prettier }, 
  javascriptreact = { prettier }, 
  typescriptreact = { prettier }, 
  json = { prettier }, 
  css = { prettier }
}

require('lspconfig').efm.setup {
  cmd = {  home .. '/.efm-langserver/bin/efm-langserver' },
  init_options = { documentFormatting = true, codeAction = true },
  filetypes = { 'typescriptreact', 'javascriptreact', 'javascript', 'typescript', 'json', 'css' },
  settings = { languages = languages },
  on_attach = on_attach,
  capabilities = capabilities,
}

require'lspconfig'.eslint.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    codeActionOnSave = {
      enable = true,
      mode = "all"
    },
  }
}

local cmp = require 'cmp'
local snippy = require 'snippy'

cmp.setup {
  snippet = {
    expand = function(args)
      snippy.lsp_expand(args.body)
    end,
  },
  formatting = {
    format = function (entry, vim_item)
      vim_item.menu = ({ buffer = '[Buffer]', nvim_lsp = '[LSP]', snippy = '[Snippy]', nvim_lua = '[Lua]' })[entry.source.name]
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
    { name = 'snippy' },
  },
}


vim.cmd[[

augroup quickfix
	autocmd!
	autocmd QuickFixCmdPost cgetexpr cwindow
	autocmd QuickFixCmdPost lgetexpr lwindow
augroup END

set runtimepath^=~/.fzf
let g:fzf_layout = { 'down': '~30%' }
let g:fzf_preview_window = ['right:40%:hidden', 'ctrl-/']

if executable("rg")
  set grepprg=rg\ --vimgrep\ --smart-case\ --hidden
  set grepformat=%f:%l:%c:%m
endif

function! Grep(...)
	return system(join([&grepprg] + [expandcmd(join(a:000, ' '))], ' '))
endfunction

command! -nargs=+ -complete=file_in_path -bar Grep  cgetexpr Grep(<f-args>)
command! -nargs=+ -complete=file_in_path -bar LGrep lgetexpr Grep(<f-args>)

autocmd TermOpen * setlocal nonumber norelativenumber

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit',
  \ 'ctrl-q': 'fill_quickfix'}

]]

-- vim: ts=2 sts=2 sw=2 et
