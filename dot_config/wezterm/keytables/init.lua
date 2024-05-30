local wezterm = require("wezterm")
local pane_mode = require("keytables.pane_mode")
local tab_mode = require("keytables.tab_mode")
local workspace_mode = require("keytables.workspace_mode")
local copy_mode = require("keytables.copy_mode")
local search_mode = require("keytables.search_mode")

local module = {}

-- Reset window frame if any key tables are not activated
wezterm.on("update-status", function(window, _)
	local overrides = window:get_config_overrides() or {}
	local name = window:active_key_table()
	if overrides.window_frame ~= nil and name == nil then
		overrides.window_frame = nil
		window:set_config_overrides(overrides)
	end
end)

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
