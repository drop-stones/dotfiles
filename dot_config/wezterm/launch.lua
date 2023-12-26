local wezterm = require("wezterm")
local act = wezterm.action
local module = {}

wezterm.on("augment-command-palette", function(window, pane)
	return {
		{
			brief = "Powershell Workspace",
			icon = "cod_terminal_powershell",
			action = act.SwitchToWorkspace({
				name = "powershell",
				spawn = {
					args = { "pwsh.exe", "-NoLogo" },
				},
			}),
		},
		{
			brief = "Msys2 Workspace",
			icon = "cod_terminal_cmd",
			action = act.SwitchToWorkspace({
				name = "msys2",
				spawn = {
					args = { "msys2.cmd", "-clang64", "-defterm", "-no-start", "-use-full-path", "-shell", "zsh" },
				},
			}),
		},
		{
			brief = "Manjaro Workspace",
			icon = "linux_manjaro",
			action = act.SwitchToWorkspace({
				name = "manjaro",
				spawn = {
					args = { "wsl", "--distribution", "Manjaro" },
				},
			}),
		},
		{
			brief = "ToggleTerm Tab",
			icon = "custom_vim",
			action = act.SpawnCommandInNewTab({
				args = {
					"msys2.cmd",
					"-clang64",
					"-defterm",
					"-no-start",
					"-use-full-path",
					"-shell",
					"zsh",
					"-c",
					"nvim -c 'ToggleTerm direction=tab'",
				},
			}),
		},
	}
end)

function module.apply_to_config(config)
	config.default_prog = { "msys2.cmd", "-clang64", "-defterm", "-no-start", "-use-full-path", "-shell", "zsh" }
end

return module
