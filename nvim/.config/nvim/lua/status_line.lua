local function get_filename()
    local file_type = vim.bo.filetype
    local icon = require('nvim-web-devicons').get_icon_by_filetype(file_type)
    if icon == nil then
       icon = ""
    end
    return table.concat({
        " ",
        icon,
        " ",
        "%f"
    })
end

Statusline = {}

Statusline.active = function()
  return table.concat {
        "%#BufferCurrent#",
        get_filename(),
        "%m%r%h%q",
        "%=",
        "%l:%c ",
  }
end

Statusline.inactive = function()
  return table.concat {
        "%#StatusLineNC#",
        get_filename(),
        "%m%r%h%q",
        "%=",
        "%l:%c ",
  }
end

function Statusline.short()
  return "%#StatusLineNC#   nvim-tree"
end

vim.api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  augroup END
]], false)
