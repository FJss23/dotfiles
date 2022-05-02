require'colorizer'.setup()

vim.opt.list = true
vim.opt.listchars:append("eol:↴")

vim.cmd [[highlight IndentBlanklineChar guifg=gray21 gui=nocombine]]
vim.cmd [[highlight IndentBlanklineChar guifg=gray21 gui=nocombine]]

require("indent_blankline").setup {
  show_end_of_line = true,
  buftype_exclude = {'terminal', 'nofile', 'NvimTree'},
  filetype_exclude = {'help', 'NvimTree'},
}


vim.g.indent_blankline_enabled = true

vim.api.nvim_set_keymap('n', '<F4>', ':IndentBlanklineToggle <CR>', { noremap = true })

require'gitsigns'.setup({
  signcolumn = true,
  signs = {
    add = { hl = 'GitSignsAdd', text = '▌ ' },
    change = { hl = 'GitSignsChange', text = '▌ ' },
    delete = { hl = 'GitSignsDelete', text = '▌ ' },
    topdelete = { hl = 'GitSignsDelete', text = '▌ ' },
    changedelete = { hl = 'GitSignsChange', text = '▌ ' },
  },
})

vim.api.nvim_set_keymap('n', '<F5>', ':Gitsigns toggle_signs <CR>', { noremap = true })

require("luasnip.loaders.from_vscode").lazy_load({ paths = { "./snippets" } })
require('nvim-autopairs').setup()

require('bqf').setup({
  preview = {
    border_chars = {'│', '│', '─', '─', '┌', '┐', '└', '┘', ''},
  }
})

require('tabout').setup {
  tabkey = '<C-l>',
  backwards_tabkey = '<C-h>'
}

require'treesitter-context'.setup()
