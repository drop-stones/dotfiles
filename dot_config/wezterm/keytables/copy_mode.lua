local wezterm = require("wezterm")
local act = wezterm.action
local utils = require("keytables.utils")

local copy_mode = nil
if wezterm.gui then
	-- Get default keytable
	copy_mode = wezterm.gui.default_key_tables().copy_mode

	-- Add new key assignments
	utils.InsertEntries(
		copy_mode,

		-- Close
		{ key = "i", action = act.CopyMode("Close") },

		-- Search
		{
			key = "/",
			action = act.Multiple({
				act.CopyMode("ClearPattern"),
				act.Search("CurrentSelectionOrEmptyString"),
			}),
		},
		{ key = "n", action = act.CopyMode("NextMatch") },
		{
			key = "N",
			mods = "SHIFT",
			action = act.CopyMode("PriorMatch"),
		}
	)
end

return copy_mode
