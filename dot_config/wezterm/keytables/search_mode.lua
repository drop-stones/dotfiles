local wezterm = require("wezterm")
local act = wezterm.action
local utils = require("keytables.utils")

local search_mode = nil
if wezterm.gui then
	-- Get default keytable
	search_mode = wezterm.gui.default_key_tables().search_mode

	-- Add new key assignments
	utils.InsertEntries(
		search_mode,

		-- Enter/Escape commands
		{ key = "Escape", action = act.CopyMode("Close") },
		{ key = "Enter", action = act.ActivateCopyMode }
	)
end

return search_mode
