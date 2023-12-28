local wezterm = require("wezterm")
local act = wezterm.action
local pane = require("keytables.pane")
local tab = require("keytables.tab")
local workspace = require("keytables.workspace")
local copy_mode = require("keytables.copy_mode")
local search_mode = require("keytables.search_mode")

local module = {}

-- Reset window frame if any key tables are not activated
wezterm.on("update-status", function(window, pane)
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
		pane = pane,

		-- Tab mode
		tab = tab,

		-- Workspace mode
		workspace = workspace,

		-- Copy mode
		copy_mode = copy_mode,

		-- Search mode
		search_mode = search_mode,
	}
end

return module
