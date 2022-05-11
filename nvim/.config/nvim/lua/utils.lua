vim.g.loaded_netrwPlugin = 1
vim.g.loaded_tutor_mode_plugin = 1
vim.g.loaded_2html_plugin = 1
vim.g.loaded_zipPlugin = 1
vim.g.loaded_tarPlugin = 1
vim.g.loaded_gzip = 1

vim.opt.list = true
vim.opt.listchars:append("eol:↴")

vim.cmd [[highlight IndentBlanklineChar guifg=gray28 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineChar guifg=gray28 gui=nocombine]]

require("indent_blankline").setup {
  show_end_of_line = true,
  buftype_exclude = {'terminal', 'nofile', 'NvimTree'},
  filetype_exclude = {'help', 'NvimTree'},
}


vim.g.indent_blankline_enabled = true

vim.api.nvim_set_keymap('n', '<F4>', ':IndentBlanklineToggle <CR>', { noremap = true })

require'gitsigns'.setup({
  signcolumn = true,
  -- signs = {
  --   add = { hl = 'GitSignsAdd', text = '▌ ' },
  --   change = { hl = 'GitSignsChange', text = '▌ ' },
  --   delete = { hl = 'GitSignsDelete', text = '▌ ' },
  --   topdelete = { hl = 'GitSignsDelete', text = '▌ ' },
  --   changedelete = { hl = 'GitSignsChange', text = '▌ ' },
  -- },
})

vim.api.nvim_set_keymap('n', '<F5>', ':Gitsigns toggle_signs <CR>', { noremap = true })

require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
require('nvim-autopairs').setup()

require('bqf').setup({
  preview = {
    border_chars = {'│', '│', '─', '─', '┌', '┐', '└', '┘', ''},
  }
})

require('nvim-tree').setup{
  git = {
    enable = false
  },
  view = {
    side = "right",
    width = '30%',
    hide_root_folder = true,
  }
}

vim.api.nvim_set_keymap('n', '<F3>', ':NvimTreeToggle <CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>nr', ':NvimTreeRefresh <CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>nf', ':NvimTreeFindFile <CR>', { noremap = true })

require'treesitter-context'.setup()
require'nvim-web-devicons'.setup{
  default = true
}

require'colorizer'.setup()

local palettes = {
  nightfox = {
    comments = "#fff"
  }
}

require'nightfox'.setup({
  palettes = palettes,
  options = {
    transparent = true,
    styles = {
      types = "bold",
      functions = "bold",
    }
  }
})

vim.cmd("colorscheme nightfox")

require'fzf-lua'.setup({
  previewers = {
    git_diff = {
      pager = "delta",
    }
  }
})

vim.api.nvim_set_keymap('n', '<leader>fp', ':FzfLua files <CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fo', ':FzfLua oldfiles <CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fb', ':FzfLua buffers <CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>fw', ':FzfLua grep_cword <CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fk', ':FzfLua live_grep_native <CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fg', ':FzfLua grep <CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>fs', ':FzfLua lsp_document_symbols <CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>ff', ':FzfLua git_files <CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fgc', ':FzfLua git_commits <CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fgb', ':FzfLua git_branches <CR>', { noremap = true })

