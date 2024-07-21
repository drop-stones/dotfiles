local wezterm = require("wezterm")
local act = wezterm.action
local tab = require("utils.tab")

local function ActiveUnlessAltScreen(window, pane, key, mods, callback)
	if pane:is_alt_screen_active() then
		window:perform_action(act.SendKey({ key = key, mods = mods }), pane)
	else
		window:perform_action(callback, pane)
	end
end

return {
	-- Copy
	{ key = "c", mods = "ALT", action = act.CopyTo("Clipboard") },

	-- Paste
	{ key = "v", mods = "ALT", action = act.PasteFrom("Clipboard") },

	-- ALT + f: Command Palette
	{ key = "f", mods = "ALT", action = act.ActivateCommandPalette },

	-- CTRL + h: Move to left pane
	{
		key = "h",
		mods = "CTRL",
		action = wezterm.action_callback(function(window, pane)
			ActiveUnlessAltScreen(window, pane, "h", "CTRL", act.ActivatePaneDirection("Left"))
		end),
	},

	-- CTRL + l: Move to right pane
	{
		key = "l",
		mods = "CTRL",
		action = wezterm.action_callback(function(window, pane)
			ActiveUnlessAltScreen(window, pane, "l", "CTRL", act.ActivatePaneDirection("Right"))
		end),
	},

	-- CTRL + j: Move to down pane
	{
		key = "j",
		mods = "CTRL",
		action = wezterm.action_callback(function(window, pane)
			ActiveUnlessAltScreen(window, pane, "j", "CTRL", act.ActivatePaneDirection("Down"))
		end),
	},

	-- CTRL + k: Move to up pane
	{
		key = "k",
		mods = "CTRL",
		action = wezterm.action_callback(function(window, pane)
			ActiveUnlessAltScreen(window, pane, "k", "CTRL", act.ActivatePaneDirection("Up"))
		end),
	},

	-- CTRL + LeftArrow: Resize pane to left
	{
		key = "LeftArrow",
		mods = "CTRL",
		action = wezterm.action_callback(function(window, pane)
			ActiveUnlessAltScreen(window, pane, "LeftArrow", "CTRL", act.AdjustPaneSize({ "Left", 2 }))
		end),
	},

	-- CTRL + RightArrow: Resize pane to right
	{
		key = "RightArrow",
		mods = "CTRL",
		action = wezterm.action_callback(function(window, pane)
			ActiveUnlessAltScreen(window, pane, "RightArrow", "CTRL", act.AdjustPaneSize({ "Right", 2 }))
		end),
	},

	-- CTRL + DownArrow: Resize pane to right
	{
		key = "DownArrow",
		mods = "CTRL",
		action = wezterm.action_callback(function(window, pane)
			ActiveUnlessAltScreen(window, pane, "DownArrow", "CTRL", act.AdjustPaneSize({ "Down", 2 }))
		end),
	},

	-- CTRL + UpArrow: Resize pane to right
	{
		key = "UpArrow",
		mods = "CTRL",
		action = wezterm.action_callback(function(window, pane)
			ActiveUnlessAltScreen(window, pane, "UpArrow", "CTRL", act.AdjustPaneSize({ "Up", 2 }))
		end),
	},

	-- ALT + a: toggle tab bar
	{
		key = "a",
		mods = "ALT",
		action = wezterm.action_callback(function(window, pane)
			tab.toggle_tab_bar(window)
		end),
	},
}
