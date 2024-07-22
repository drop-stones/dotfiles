local wezterm = require("wezterm")
local act = wezterm.action
local modes = require("utils.modes")
local tab = require("appearance.tab")
local util_tab = require("utils.tab")

function ActionAndChangeWindowFrameColor(window, pane, mode, action)
	tab.update_tab_bar(window, pane)
	util_tab.enable_tab_bar(window)

	window:perform_action(action, pane)
end

function ActivateKeyTableAndChangeWindowFrameColor(window, pane, mode)
	ActionAndChangeWindowFrameColor(
		window,
		pane,
		mode,
		act.ActivateKeyTable({
			name = mode,
			one_shot = false,
			replace_current = true,
			until_unknown = true,
		})
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
			ActionAndChangeWindowFrameColor(window, pane, "copy_mode", act.ActivateCopyMode)

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
			ActivateKeyTableAndChangeWindowFrameColor(window, pane, "pane_mode")
		end),
	},

	-- ALT + t: tab mode
	{
		key = "t",
		mods = "ALT",
		action = wezterm.action_callback(function(window, pane)
			ActivateKeyTableAndChangeWindowFrameColor(window, pane, "tab_mode")
		end),
	},

	-- ALT + w: workspace mode
	{
		key = "w",
		mods = "ALT",
		action = wezterm.action_callback(function(window, pane)
			ActivateKeyTableAndChangeWindowFrameColor(window, pane, "workspace_mode")
		end),
	},
}
