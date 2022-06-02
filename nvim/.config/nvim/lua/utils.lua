vim.g.loaded_netrw            = 1
vim.g.loaded_netrwPlugin      = 1
vim.g.loaded_matchparen       = 1
vim.g.loaded_matchit          = 1
vim.g.loaded_2html_plugin     = 1
vim.g.loaded_getscriptPlugin  = 1
vim.g.loaded_gzip             = 1
vim.g.loaded_logipat          = 1
vim.g.loaded_rrhelper         = 1
vim.g.loaded_spellfile_plugin = 1
vim.g.loaded_tarPlugin        = 1
vim.g.loaded_vimballPlugin    = 1
vim.g.loaded_zipPlugin        = 1

vim.opt.list = true
vim.opt.listchars:append("eol:↴")

vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_enabled = true

-- @Info Change the color of the underline when using show_current_context_start
-- vim.cmd [[highlight IndentBlanklineContextStart guisp=gray49 gui=underline]]

require("indent_blankline").setup {
  show_end_of_line = true,
  buftype_exclude = {'terminal', 'nofile', 'NvimTree'},
  filetype_exclude = {'help', 'NvimTree'},
  show_current_context = true,
  -- show_current_context_start = true,
  char_highlight_list = {"IndentBlanklineIndent1"},
}

vim.cmd [[highlight IndentBlanklineIndent1 guifg=gray23 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineContextChar  guifg=gray35 gui=nocombine]]

-- vim.api.nvim_set_keymap('n', '<F4>', ':IndentBlanklineToggle <CR>', { noremap = true })

require'gitsigns'.setup({
  signs = {
    add = { hl = 'GitSignsAdd', text = '▌' },
    change = { hl = 'GitSignsChange', text = '▌' },
    delete = { hl = 'GitSignsDelete', text = '▌' },
    topdelete = { hl = 'GitSignsDelete', text = '▌' },
    changedelete = { hl = 'GitSignsChange', text = '▌' },
  },
  signcolumn = true,
  current_line_blame = false
})

-- vim.api.nvim_set_keymap('n', '<F5>', ':Gitsigns toggle_signs <CR>', { noremap = true })

require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })

require('nvim-tree').setup{
  git = {
    enable = false
  },
  view = {
    side = "right",
    width = '25%',
  }
}

vim.api.nvim_set_keymap('n', '<F3>', ':NvimTreeToggle <CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>nr', ':NvimTreeRefresh <CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>nf', ':NvimTreeFindFile <CR>', { noremap = true })

require'treesitter-context'.setup()

require'colorizer'.setup()

require'fzf-lua'.setup({
  winopts = {
    width = 0.6,
    height = 0.4,
    -- split = "belowright new",
    preview = {
      hidden = "hidden",
    }
  },
  files = {
    git_icons = false
  }
})

---@diagnostic disable-next-line: lowercase-global
function ide_mode()
  vim.cmd(":Gitsigns toggle_signs")
  vim.cmd(":Gitsigns toggle_current_line_blame")
  vim.cmd(':IndentBlanklineToggle')
  print("ey!")
end

vim.api.nvim_set_keymap('n', '<leader>ff', ':FzfLua files <CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fo', ':FzfLua oldfiles <CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fb', ':FzfLua buffers <CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>fw', ':FzfLua grep_cword <CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fk', ':FzfLua live_grep_native <CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fg', ':FzfLua grep <CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>fs', ':FzfLua lsp_document_symbols <CR>', { noremap = true })

vim.api.nvim_set_keymap('n', '<leader>fi', ':FzfLua git_files <CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fgc', ':FzfLua git_commits <CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>fgb', ':FzfLua git_branches <CR>', { noremap = true })


-- Shut down sometings
vim.api.nvim_set_keymap('n', '<F6>', '<cmd>lua ide_mode()<CR>', { noremap = true})

require('nvim-web-devicons').setup()
require('Comment').setup()
