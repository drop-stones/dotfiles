local wezterm = require("wezterm")
local act = wezterm.action

local copy_mode = nil
if wezterm.gui then
	copy_mode = wezterm.gui.default_key_tables().copy_mode
	table.insert(copy_mode, {
		key = "/",
		mods = "NONE",
		action = act.Search({ CaseSensitiveString = "" }),
	})
end

return copy_mode
