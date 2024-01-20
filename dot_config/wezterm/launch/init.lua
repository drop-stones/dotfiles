local wezterm = require("wezterm")
local spawn = require("spawn")
local spawn_utils = require("spawn.utils")

local module = {}

wezterm.on("augment-command-palette", function(window, pane)
	return spawn.get_spawn_commands_for_palette()
end)

function module.apply_to_config(config)
	if spawn_utils.IsWindows() then
		config.default_prog = spawn_utils.Msys2Commands()
		config.wsl_domains = wezterm.default_wsl_domains()
	end
end

return module
