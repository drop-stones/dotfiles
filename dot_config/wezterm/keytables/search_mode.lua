local wezterm = require("wezterm")
local act = wezterm.action

local search_mode = nil
if wezterm.gui then
	search_mode = wezterm.gui.default_key_tables().search_mode
	table.insert(search_mode, {
		key = "Escape",
		mods = "NONE",
		action = act.ActivateCopyMode,
	})
end

return search_mode
