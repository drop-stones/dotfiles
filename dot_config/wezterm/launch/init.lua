local wezterm = require("wezterm")
local windows = require("launch.windows")
local utils_os = require("utils.os")

local command_palette = require("launch.command_palette")

local module = {}

wezterm.on("augment-command-palette", function(window, pane)
	return command_palette
end)

function module.apply_to_config(config)
	if utils_os.IsWindows() then
		windows.apply_to_config(config)
	end
end

return module
