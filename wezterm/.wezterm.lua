local wezterm = require 'wezterm'

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
  local pane_title = tab.active_pane.title
  local user_title = tab.active_pane.user_vars.panetitle

  if user_title ~= nil and #user_title > 0 then
    pane_title = user_title
  end

  return {
    {Text="  " .. pane_title .. "  "},
  }
end)

return {
	font_size = 12,
	font = wezterm.font 'CodeNewRoman Nerd Font',
    color_scheme = --[[ 'tokyonight'  ]]'tokyonight-day',
	check_for_updates = false,
	hide_tab_bar_if_only_one_tab = true,
	use_fancy_tab_bar = false,
	harfbuzz_features = {"calt=0", "clig=0", "liga=0"},
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
    initial_cols = 180,
    initial_rows = 45,
	leader = { key = "a", mods = "CTRL" },
	keys = {
		{ key = "-", mods = "LEADER",       action=wezterm.action{SplitVertical={domain="CurrentPaneDomain"}}},
		{ key = "ñ", mods = "LEADER",       action=wezterm.action{SplitHorizontal={domain="CurrentPaneDomain"}}},
		{ key = "z", mods = "LEADER",       action="TogglePaneZoomState" },
		{ key = "t", mods = "LEADER",       action=wezterm.action{SpawnTab="CurrentPaneDomain"}},
		{ key = "h", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Left"}},
		{ key = "j", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Down"}},
		{ key = "k", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Up"}},
		{ key = "l", mods = "LEADER",       action=wezterm.action{ActivatePaneDirection="Right"}},
		{ key = "H", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Left", 10}}},
		{ key = "J", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Down", 10}}},
		{ key = "K", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Up", 10}}},
		{ key = "L", mods = "LEADER|SHIFT", action=wezterm.action{AdjustPaneSize={"Right", 10}}},
		{ key = "1", mods = "LEADER",       action=wezterm.action{ActivateTab=0}},
		{ key = "2", mods = "LEADER",       action=wezterm.action{ActivateTab=1}},
		{ key = "3", mods = "LEADER",       action=wezterm.action{ActivateTab=2}},
		{ key = "4", mods = "LEADER",       action=wezterm.action{ActivateTab=3}},
		{ key = "5", mods = "LEADER",       action=wezterm.action{ActivateTab=4}},
		{ key = "6", mods = "LEADER",       action=wezterm.action{ActivateTab=5}},
		{ key = "7", mods = "LEADER",       action=wezterm.action{ActivateTab=6}},
		{ key = "8", mods = "LEADER",       action=wezterm.action{ActivateTab=7}},
		{ key = "9", mods = "LEADER",       action=wezterm.action{ActivateTab=8}},
		{ key = "c", mods = "LEADER", 	    action=wezterm.action{CloseCurrentTab={confirm=true}}},
		{ key = "x", mods = "LEADER",       action=wezterm.action{CloseCurrentPane={confirm=true}}},
	},
}
