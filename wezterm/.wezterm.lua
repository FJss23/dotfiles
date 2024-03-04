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
    local icon = '⚡'
    for _, b in ipairs(wezterm.battery_info()) do
        if b.state == 'Charging' then
            icon = '🔌'
        end
        if b.state == 'Empty' then
            icon = '⚠️'
        end

        bat = icon .. ' ' .. string.format('%.0f%%', b.state_of_charge * 100)
    end

    local ws = window:active_workspace()

    window:set_right_status(wezterm.format {
        { Text = --[[ wezterm.hostname() ]] ws .. '  ' .. bat .. ' ' .. date },
    })
end)

config.font_size = 12
config.font = wezterm.font 'CodeNewRoman Nerd Font'
config.color_scheme = 'Retro'
-- config.color_scheme = 'tlh (terminal.sexy)'
-- config.color_scheme = 'Tokyo Night Moon'
config.color_scheme = 'Dracula'
-- config.color_scheme = 'Gruvbox dark, hard (base16)'
config.check_for_updates = false
config.hide_tab_bar_if_only_one_tab = false
config.use_fancy_tab_bar = false
config.harfbuzz_features = {"calt=0", "clig=0", "liga=0"}
config.tab_bar_at_bottom = true
config.window_padding = { left = 0, right = 0, top = 0, bottom = 0 }
config.initial_cols = 180
config.initial_rows = 45
config.leader = { key = "ñ"}
config.keys = {
    { key = "-", mods = "LEADER",       action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
    { key = "ñ", mods = "LEADER",       action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
    { key = "z", mods = "LEADER",       action="TogglePaneZoomState" },
    { key = "t", mods = "LEADER",       action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
    { key = "h", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Left"}},
    { key = "j", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Down"}},
    { key = "k", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Up"}},
    { key = "l", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Right"}},
    { key = "H", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Left", 5}}},
    { key = "J", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Down", 5}}},
    { key = "K", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Up", 5}}},
    { key = "L", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Right", 5}}},
    { key = "1", mods = "LEADER",       action=wezterm.action{ActivateTab=0}},
    { key = "2", mods = "LEADER",       action=wezterm.action{ActivateTab=1}},
    { key = "3", mods = "LEADER",       action=wezterm.action{ActivateTab=2}},
    { key = "4", mods = "LEADER",       action=wezterm.action{ActivateTab=3}},
    { key = "5", mods = "LEADER",       action=wezterm.action{ActivateTab=4}},
    { key = "6", mods = "LEADER",       action=wezterm.action{ActivateTab=5}},
    { key = "7", mods = "LEADER",       action=wezterm.action{ActivateTab=6}},
    { key = "8", mods = "LEADER",       action=wezterm.action{ActivateTab=7}},
    { key = "c", mods = "LEADER", 	    action=wezterm.action{CloseCurrentTab={confirm=true}}},
    { key = "x", mods = "LEADER",       action=wezterm.action{CloseCurrentPane={confirm=true}}},
  -- Switch to the default workspace
  {
    key = 'y',
    mods = 'LEADER',
    action = act.SwitchToWorkspace {
      name = 'default',
    },
  },
  -- Switch to a monitoring workspace, which will have `top` launched into it
  {
    key = 'u',
    mods = 'LEADER',
    action = act.SwitchToWorkspace {
      name = 'monitoring',
      spawn = {
        args = { 'htop' },
      },
    },
  },
  -- Create a new workspace with a random name and switch to it
  { key = 'i', mods = 'LEADER', action = act.SwitchToWorkspace },
  -- Show the launcher in fuzzy selection mode and have it list all workspaces
  -- and allow activating one.
  {
    key = '9',
    mods = 'LEADER',
    action = act.ShowLauncherArgs {
      flags = 'FUZZY|WORKSPACES',
    },
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
  { key = 'o', mods = 'LEADER', action = wezterm.action.ShowTabNavigator },
    {
        key = 'e',
        mods = 'LEADER',
        action = act.PromptInputLine {
            description = 'Enter new name for tab',
            action = wezterm.action_callback(function(window, pane, line)
                if line then
                    window:active_tab():set_title(line)
                end
            end)
        }
    }
}

return config

