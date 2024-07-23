local wezterm = require("wezterm")
local windows = require("utils.command.windows")

local module = {}

function module.apply_to_config(config)
	config.default_prog = windows.Msys2Commands()
	config.wsl_domains = wezterm.default_wsl_domains()
end

return module
