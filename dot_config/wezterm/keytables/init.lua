local wezterm = require("wezterm")
local pane_mode = require("keytables.pane_mode")
local tab_mode = require("keytables.tab_mode")
local workspace_mode = require("keytables.workspace_mode")
local copy_mode = require("keytables.copy_mode")
local search_mode = require("keytables.search_mode")

local module = {}

function module.apply_to_config(config)
	config.key_tables = {
		-- Pane mode
		pane_mode = pane_mode,

		-- Tab mode
		tab_mode = tab_mode,

		-- Workspace mode
		workspace_mode = workspace_mode,

		-- Copy mode
		copy_mode = copy_mode,

		-- Search mode
		search_mode = search_mode,
	}
end

return module
