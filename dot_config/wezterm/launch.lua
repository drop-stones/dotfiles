local wezterm = require("wezterm")
local module = {}
local launch_menu = {}

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	table.insert(launch_menu, {
		label = "PowerShell",
		args = { "powershell.exe", "-NoLogo" },
	})
end

function module.apply_to_config(config)
	config.default_prog = { "msys2.cmd", "-clang64", "-defterm", "-no-start", "-use-full-path", "-shell", "zsh" }
	config.default_cwd = "$HOME"

	config.launch_menu = launch_menu
end

return module
