local wezterm = require("wezterm")
local command = require("utils.command")

local module = {}

function module.apply_to_config(config)
	config.default_prog = command.ZshCommands()
	config.default_domain = wezterm.default_wsl_domains()[1].name
	config.wsl_domains = wezterm.default_wsl_domains()
end

return module
