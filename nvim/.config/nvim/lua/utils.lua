-- Config for various plugins
require'colorizer'.setup()
require'nvim-ts-autotag'.setup()

vim.opt.list = true
vim.opt.listchars:append("eol:↴")

require("indent_blankline").setup {
  show_end_of_line = true,
  buftype_exclude = {'terminal', 'nofile', 'NvimTree'},
  filetype_exclude = {'help', 'NvimTree'},
  -- show_current_context = true,
  -- show_current_context_start = true,
}

vim.g.indent_blankline_enabled = true

vim.api.nvim_set_keymap('n', '<F4>', ':IndentBlanklineToggle <CR>', { noremap = true })

require'nvim-tree'.setup{
  disable_netrw = true,
  git = {
    enable = false,
  },
  view = {
    hide_root_folder = false,
    side = 'right',
    width = '30%',
    height = '30%',
  },
  diagnostics = {
    enable = true,
    show_on_dirs = true,
    icons = {
      hint = "",
      info = "",
      warning = "",
      error = "",
    }
   }
}

vim.api.nvim_set_keymap('n', '<F3>', ':NvimTreeToggle <CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>nr', ':NvimTreeRefresh <CR>', { noremap = true })
vim.api.nvim_set_keymap('n', '<leader>nf', ':NvimTreeFindFile <CR>', { noremap = true })

require'gitsigns'.setup({
  signcolumn = true,
  signs = {
    add = { hl = 'GitSignsAdd', text = ' ▌' },
    change = { hl = 'GitSignsChange', text = ' ▌' },
    delete = { hl = 'GitSignsDelete', text = ' ▌' },
    topdelete = { hl = 'GitSignsDelete', text = ' ▌' },
    changedelete = { hl = 'GitSignsChange', text = ' ▌' },
  },
})

vim.api.nvim_set_keymap('n', '<F5>', ':Gitsigns toggle_signs <CR>', { noremap = true })

require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
require('telescope').load_extension('fzf')
require('nvim-autopairs').setup()
