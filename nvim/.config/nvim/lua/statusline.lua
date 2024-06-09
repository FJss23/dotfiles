vim.api.nvim_create_autocmd('TermOpen', {
  callback = function()
    vim.o.number = false
    vim.o.relativenumber = false
  end,
  pattern = '*',
})

local function filepath()
  local fpath = vim.fn.fnamemodify(vim.fn.expand "%", ":~:.:h")
  if fpath == "" or fpath == "." then return " " end

  return string.format(" %%<%s/", fpath)
end

local function filename()
  local fname = vim.fn.expand "%:t"
  if fname == "" then return "" end
  return fname .. " "
end

local function lsp()
  local count = {}
  local levels = { errors = "Error", warnings = "Warn", info = "Info", hints = "Hint" }

  for k, level in pairs(levels) do
    count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
  end

  local lsp_info = "["
  if count["errors"] > 0 then
    lsp_info = lsp_info .. "%#DiagnosticError#E" .. count["errors"] .. "%#StatusLine# "
  end
  if count["warnings"] > 0 then
    lsp_info = lsp_info .. "%#DiagnosticWarn#W" .. count["warnings"] .. "%#StatusLine# "
  end
  if count["hints"] > 0 then
    lsp_info = lsp_info .. "%#DiagnosticHint#H" .. count["hints"] .. "%#StatusLine# "
  end
  if count["info"] > 0 then
    lsp_info = lsp_info .. "%#DiagnosticInfo#I" .. count["info"] .. "%#StatusLine#"
  end
  lsp_info = lsp_info .. "]"

  if lsp_info:len() == 2 then
    lsp_info = ""
  end

  return lsp_info
  -- return "[E" .. count["errors"] .. " W" .. count["warnings"] .. " H" .. count["hints"] .. " I" .. count["info"] .. "]"
end

local function filetype() return "[" .. string.format("%s", vim.bo.filetype) .. "]" end

local function lineinfo()
  if vim.bo.filetype == "alpha" then return "" end
  return " %l:%c %L "
end

local function branch_name()
  local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
  if branch ~= "" then
    return branch
  else
    return ""
  end
end

statusline = {}

statusline.active = function()
  return table.concat {
    " ",
    branch_name(),
    " |",
    filepath(),
    filename(),
    "%m%r",
    "%=",
    lsp(),
    " ",
    "%{ &ff != 'unix' ? '['.&ff.'] ' : '' }",
    filetype(),
    lineinfo()
  }
end

function statusline.inactive() return " %F" end

vim.api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.statusline.inactive()
  augroup END
]], false)
