local wezterm = require 'wezterm'
local config = {}
local act = wezterm.action

if wezterm.config_builder then
  config = wezterm.config_builder()
end

wezterm.on('update-right-status', function(window, pane)
  -- "Wed Mar 3 08:14"
  local date = wezterm.strftime '%a %b %-d %H:%M '

  local bat = ''
  local icon = '󱧥'
  for _, b in ipairs(wezterm.battery_info()) do
    if b.state == 'Charging' then
      icon = '󰂄'
    end
    if b.state == 'Empty' then
      icon = '󰂎'
    end

    bat = icon .. '  ' .. string.format('%.0f%%', b.state_of_charge * 100)
  end

  local ws = window:active_workspace()

  window:set_right_status(wezterm.format {
    { Text = --[[ wezterm.hostname() ]] '󰇄  ' .. ws .. '  ' .. bat .. '    ' .. date },
  })
end)

wezterm.on("toggle-tabbar", function(window, _)
  local overrides = window:get_config_overrides() or {}
  if overrides.enable_tab_bar == false then
    wezterm.log_info("tab bar shown")
    overrides.enable_tab_bar = true
  else
    wezterm.log_info("tab bar hidden")
    overrides.enable_tab_bar = false
  end
  window:set_config_overrides(overrides)
end)

local function is_inside_vim(pane)
  local tty = pane:get_tty_name()
  if tty == nil then return false end

  local success, stdout, stderr = wezterm.run_child_process
      { 'sh', '-c',
        'ps -o state= -o comm= -t' .. wezterm.shell_quote_arg(tty) .. ' | ' ..
        'grep -iqE \'^[^TXZ ]+ +(\\S+\\/)?g?(view|l?n?vim?x?)(diff)?$\'' }

  return success
end

local function is_outside_vim(pane)
  return not is_inside_vim(pane)
end

local function bind_if(cond, key, mods, action)
  local function callback(win, pane)
    if cond(pane) then
      win:perform_action(action, pane)
    else
      win:perform_action(act.SendKey({ key = key, mods = mods }), pane)
    end
  end

  return {
    key = key, mods = mods, action = wezterm.action_callback(callback)
  }
end

config.font_size = 12
config.font = wezterm.font 'JetBrainsMono Nerd Font'
-- config.font = wezterm.font 'CodeNewRoman Nerd Font'
config.line_height = 1.1
config.color_scheme = 'GruvboxDarkHard'
-- config.color_scheme = 'Dracula'
-- https://wezfurlong.org/wezterm/config/appearance.html#defining-your-own-colors
config.colors = {
  background = '#1b1b1b',
  cursor_bg = '#ffffff',
  cursor_fg = 'black',
  tab_bar = {
    background = '#1b1b1b',
    active_tab = {
      bg_color = '#ffffff',
      fg_color = '#000000'
    }
  }
}
config.inactive_pane_hsb = {
  brightness = 0.5
}
config.check_for_updates = false
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.harfbuzz_features = { "calt=0", "clig=0", "liga=0" }
config.tab_bar_at_bottom = true
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.initial_cols = 180
config.initial_rows = 45
config.leader = { key = "ñ" }
config.keys = {
  {
    key = "-",
    mods = "LEADER",
    action = act {
      SplitVertical = { domain = "CurrentPaneDomain" }
    }
  },
  {
    key = "ñ",
    mods = "LEADER",
    action = act {
      SplitHorizontal = { domain = "CurrentPaneDomain" }
    }
  },
  {
    key = "z", mods = "LEADER", action = "TogglePaneZoomState"
  },
  {
    key = "t",
    mods = "LEADER",
    action = act { SpawnTab = "CurrentPaneDomain" }
  },
  {
    key = "h",
    mods = "LEADER",
    action = act { ActivatePaneDirection = "Left" }
  },
  {
    key = "j",
    mods = "LEADER",
    action = act { ActivatePaneDirection = "Down" }
  },
  {
    key = "k",
    mods = "LEADER",
    action = act { ActivatePaneDirection = "Up" }
  },
  {
    key = "l",
    mods = "LEADER",
    action = act { ActivatePaneDirection = "Right" }
  },
  {
    key = "H",
    mods = "LEADER|SHIFT",
    action = act { AdjustPaneSize = { "Left", 5 } }
  },
  {
    key = "J",
    mods = "LEADER|SHIFT",
    action = act { AdjustPaneSize = { "Down", 5 } }
  },
  {
    key = "K",
    mods = "LEADER|SHIFT",
    action = act { AdjustPaneSize = { "Up", 5 } }
  },
  {
    key = "L",
    mods = "LEADER|SHIFT",
    action = act { AdjustPaneSize = { "Right", 5 } }
  },
  {
    key = "1",
    mods = "LEADER",
    action = act { ActivateTab = 0 }
  },
  {
    key = "2",
    mods = "LEADER",
    action = act { ActivateTab = 1 }
  },
  {
    key = "3",
    mods = "LEADER",
    action = act { ActivateTab = 2 }
  },
  {
    key = "4",
    mods = "LEADER",
    action = act { ActivateTab = 3 }
  },
  {
    key = "5",
    mods = "LEADER",
    action = act { ActivateTab = 4 }
  },
  {
    key = "6",
    mods = "LEADER",
    action = act { ActivateTab = 5 }
  },
  {
    key = "7",
    mods = "LEADER",
    action = act { ActivateTab = 6 }
  },
  {
    key = "8",
    mods = "LEADER",
    action = act { ActivateTab = 7 }
  },
  {
    key = "c",
    mods = "LEADER",
    action = act { CloseCurrentTab = { confirm = true } }
  },
  {
    key = "x",
    mods = "LEADER",
    action = act { CloseCurrentPane = { confirm = true } }
  },
  -- Switch to the default workspace
  {
    key = 'y',
    mods = 'LEADER',
    action = act.SwitchToWorkspace { name = 'default', },
  },
  {
    key = 'g',
    mods = 'LEADER',
    action = act.SwitchToWorkspace {
      name = 'git',
      spawn = { args = { 'lazygit' }, },
    },
  },
  {
    key = 'u',
    mods = 'LEADER',
    action = act.SwitchToWorkspace {
      name = 'monitoring',
      spawn = { args = { 'btop' }, },
    },
  },
  -- Create a new workspace with a random name and switch to it
  {
    key = 'i',
    mods = 'LEADER',
    action = act.SwitchToWorkspace
  },
  -- Show the launcher in fuzzy selection mode and have it list all workspaces
  -- and allow activating one.
  {
    key = '9',
    mods = 'LEADER',
    action = act.ShowLauncherArgs { flags = 'FUZZY|WORKSPACES', },
  },

  -- Prompt for a name to use for a new workspace and switch to it.
  {
    key = 'w',
    mods = 'LEADER',
    action = act.PromptInputLine {
      description = wezterm.format {
        { Attribute = { Intensity = 'Bold' } },
        { Foreground = { AnsiColor = 'Fuchsia' } },
        { Text = 'Enter name for new workspace' },
      },
      action = wezterm.action_callback(function(window, pane, line)
        -- line will be `nil` if they hit escape without entering anything
        -- An empty string if they just hit enter
        -- Or the actual line of text they wrote
        if line then
          window:perform_action(
            act.SwitchToWorkspace {
              name = line,
            },
            pane
          )
        end
      end),
    },
  },
  {
    key = 'o', mods = 'LEADER', action = act.ShowTabNavigator
  },
  {
    key = 'e',
    mods = 'LEADER',
    action = act.PromptInputLine {
      description = 'Enter new name for tab',
      action = wezterm.action_callback(function(window, _pane, line)
        if line then
          window:active_tab():set_title(line)
        end
      end)
    }
  },
  {
    key = 'H', mods = 'LEADER', action = act.EmitEvent("toggle-tabbar")
  },
  -- rotate panes
  {
    mods = "LEADER",
    key = "Space",
    action = act.RotatePanes "Clockwise"
  },
  -- show the pane selection mode, but have it swap the active and selected panes
  {
    mods = 'LEADER',
    key = '0',
    action = act.PaneSelect {
      mode = 'SwapWithActive',
    },
  },
  bind_if(is_outside_vim, 'h', 'ALT', act.ActivatePaneDirection('Left')),
  bind_if(is_outside_vim, 'l', 'ALT', act.ActivatePaneDirection('Right')),
  bind_if(is_outside_vim, 'k', 'ALT', act.ActivatePaneDirection('Up')),
  bind_if(is_outside_vim, 'j', 'ALT', act.ActivatePaneDirection('Down')),
  bind_if(is_outside_vim, 'p', 'ALT', act.ActivatePaneDirection('Prev')),
}

return config
