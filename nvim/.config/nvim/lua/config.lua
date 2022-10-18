require("nvim-treesitter.configs").setup({
    highlight = {
        enable = true,
    },
    autotag = { enable = true },
    context_commentstring = {
        enable = true,
    },
    indent = {
        enable = true
    }
})

require('treesitter-context').setup({
    highlight = { enable = true },
    indent = { enable = true }
})

require('telescope').setup({})
require('telescope').load_extension('fzf')

require('nvim-autopairs').setup({})

require('gitsigns').setup({})

require('colorizer').setup({})

require('nvim-custom-diagnostic-highlight').setup({})

require('nvim-tree').setup({
    view = {
        width = 40,
        side = "right"
    },
    renderer = {
        icons =  {
            git_placement = "after"
        }
    }
})

require('nvim-web-devicons').setup({})

require('code_action').listener()

require('lsp')

require('status_line')
