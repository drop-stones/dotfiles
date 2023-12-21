local wezterm = require("wezterm")
local act = wezterm.action
local module = {}

function module.apply_to_config(config)
	config.use_ime = true

	config.keys = {
		-- Quick Select Mode
		{ key = "m", mods = "CTRL", action = act.QuickSelect },

		-- Copy Mode
		{ key = "n", mods = "CTRL", action = act.ActivateCopyMode },

		-- Paste
		{ key = "v", mods = "CTRL", action = act.PasteFrom("Clipboard") },

		-- Zellij-style keybindings
		-- CTRL + p: pane mode
		{
			key = "p",
			mods = "CTRL",
			action = act.ActivateKeyTable({
				name = "pane",
				one_shot = false,
				replace_current = true,
				until_unknown = true,
			}),
		},

		-- CTRL + t: tab mode
		{
			key = "t",
			mods = "CTRL",
			action = act.ActivateKeyTable({
				name = "tab",
				one_shot = false,
				replace_current = true,
				until_unknown = true,
			}),
		},

		-- CTRL + w: workspace mode
		{
			key = "w",
			mods = "CTRL",
			action = act.ActivateKeyTable({
				name = "workspace",
				one_shot = false,
				replace_current = true,
				until_unknown = true,
			}),
		},
	}
end

return module
