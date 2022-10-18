-- based on https://nuxsh.is-a.dev/blog/custom-nvim-statusline.html

local function filepath()
  local fpath = vim.fn.fnamemodify(vim.fn.expand "%", ":~:.:h")
  if fpath == "" or fpath == "." then
      return " "
  end

  return string.format(" %%<%s/", fpath)
end

local function filename()
  local fname = vim.fn.expand "%:t"
  if fname == "" then
      return ""
  end
  return fname .. " "
end

local function lsp()
  local count = {}
  local levels = {
    errors = "Error",
    warnings = "Warn",
    info = "Info",
    hints = "Hint",
  }

  for k, level in pairs(levels) do
    count[k] = vim.tbl_count(vim.diagnostic.get(0, { severity = level }))
  end

  local errors = ""
  local warnings = ""
  local hints = ""
  local info = ""

  if count["errors"] ~= 0 then
    errors = "E:" .. count["errors"]
  end
  if count["warnings"] ~= 0 then
    warnings = "W:" .. count["warnings"]
  end
  if count["hints"] ~= 0 then
    hints = "H:" .. count["hints"]
  end
  if count["info"] ~= 0 then
    info = "I:" .. count["info"]
  end

  if errors == "" and warnings == "" and hints == "" and info == "" then
      return ""
  else
    return "| " .. errors .. "" .. warnings .. "" ..  hints .. "" .. info .. " "
  end
end

local function filetype()
  return string.format("| %s ", vim.bo.filetype):upper()
end

local function lineinfo()
  if vim.bo.filetype == "alpha" then
    return ""
  end
  return "| 並%P %l:%c "
end

local vcs = function()
  local git_info = vim.b.gitsigns_status_dict
  if not git_info or git_info.head == "" then
    return ""
  end
  local added = git_info.added and ("+" .. git_info.added .. " ") or ""
  local changed = git_info.changed and ("~" .. git_info.changed .. " ") or ""
  local removed = git_info.removed and ("-" .. git_info.removed .. " ") or ""
  if git_info.added == 0 then
    added = ""
  end
  if git_info.changed == 0 then
    changed = ""
  end
  if git_info.removed == 0 then
    removed = ""
  end
  return table.concat {
     added,
     changed,
     removed,
     " ",
     git_info.head,
     " ",
  }
end

Statusline = {}

Statusline.active = function()
  return table.concat {
    "%#BufferCurrent#",
    filepath(),
    filename(),
    "%=",
    vcs(),
    lsp(),
    filetype(),
    lineinfo(),
  }
end

function Statusline.inactive()
  return " %F"
end

function Statusline.short()
  return "%#StatusLineNC#   NvimTree"
end

vim.api.nvim_exec([[
  augroup Statusline
  au!
  au WinEnter,BufEnter * setlocal statusline=%!v:lua.Statusline.active()
  au WinLeave,BufLeave * setlocal statusline=%!v:lua.Statusline.inactive()
  au WinEnter,BufEnter,FileType NvimTree setlocal statusline=%!v:lua.Statusline.short()
  augroup END
]], false)
