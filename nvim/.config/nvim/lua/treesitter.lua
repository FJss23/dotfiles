-- Configuration for nvim-treesitter plugin

local enabled_list = { 'clojure' }
local parsers = require("nvim-treesitter.parsers")

require'nvim-treesitter.configs'.setup {
  autotag = {
    enable = true
  },
  highlight = { enable = true },
  incremental_selection = { enable = true },
  textobjects = { enable = true },
  rainbow = {
    enable = true,
    -- disable = vim.tbl_filter(
		-- function(p)
			-- local disable = true
			-- for _, lang in ipairs(enabled_list) do
				-- if p == lang then disable = false end
			-- end
			-- return disable
		-- end,
		-- parsers.available_parsers()
	  -- )
	}
  }
