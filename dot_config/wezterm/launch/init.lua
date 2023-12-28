local wezterm = require("wezterm")
local act = wezterm.action
local utils = require("launch.utils")
local command_palette = require("launch.command_palette")

local module = {}

wezterm.on("augment-command-palette", function(window, pane)
	return command_palette
end)

function module.apply_to_config(config)
	config.default_prog = utils.Msys2Commands()
end

return module
