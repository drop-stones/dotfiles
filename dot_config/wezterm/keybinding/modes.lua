local wezterm = require("wezterm")
local act = wezterm.action
local tab = require("appearance.tab")
local util_tab = require("utils.tab")

function ActivateKeyTableAndShowTabBar(window, pane, mode)
	tab.update_tab_bar(window, pane)
	util_tab.enable_tab_bar(window)

	window:perform_action(
		act.ActivateKeyTable({
			name = mode,
			one_shot = false,
			replace_current = true,
			until_unknown = true,
		}),
		pane
	)
end

return {
	-- Quick Select Mode
	{ key = "s", mods = "ALT", action = act.QuickSelect },

	-- Copy Mode
	{
		key = "n",
		mods = "ALT",
		action = wezterm.action_callback(function(window, pane)
			window:perform_action(act.ActivateCopyMode, pane)

			-- Clear previous state
			window:perform_action(act.CopyMode("ClearPattern"), pane)
			window:perform_action(act.CopyMode("ClearSelectionMode"), pane)
		end),
	},

	-- Zellij-style keybindings
	-- ALT + p: pane mode
	{
		key = "p",
		mods = "ALT",
		action = wezterm.action_callback(function(window, pane)
			ActivateKeyTableAndShowTabBar(window, pane, "pane_mode")
		end),
	},

	-- ALT + t: tab mode
	{
		key = "t",
		mods = "ALT",
		action = wezterm.action_callback(function(window, pane)
			ActivateKeyTableAndShowTabBar(window, pane, "tab_mode")
		end),
	},

	-- ALT + w: workspace mode
	{
		key = "w",
		mods = "ALT",
		action = wezterm.action_callback(function(window, pane)
			ActivateKeyTableAndShowTabBar(window, pane, "workspace_mode")
		end),
	},
}
