local wezterm = require("wezterm")
local act = wezterm.action

return {
	-- Copy
	{ key = "c", mods = "ALT", action = act.CopyTo("Clipboard") },

	-- Paste
	{ key = "v", mods = "ALT", action = act.PasteFrom("Clipboard") },

	-- ALT + f: Command Palette
	{ key = "f", mods = "ALT", action = act.ActivateCommandPalette },

	-- CTRL + h: Move to left pane
	{ key = "h", mods = "CTRL", action = act.ActivatePaneDirection("Left") },

	-- CTRL + l: Move to right pane
	{ key = "l", mods = "CTRL", action = act.ActivatePaneDirection("Right") },

	-- CTRL + j: Move to down pane
	{ key = "j", mods = "CTRL", action = act.ActivatePaneDirection("Down") },

	-- CTRL + k: Move to up pane
	{ key = "k", mods = "CTRL", action = act.ActivatePaneDirection("Up") },
}
