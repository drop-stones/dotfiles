local wezterm = require("wezterm")
local act = wezterm.action
local private = require("launch.command_palette.private")
local utils = require("launch.utils")

local commands = {
	{
		brief = "Powershell Workspace",
		icon = "cod_terminal_powershell",
		action = act.SwitchToWorkspace({
			name = "powershell",
			spawn = {
				args = utils.PowerShellCommands(),
			},
		}),
	},
	{
		brief = "Msys2 Workspace",
		icon = "cod_terminal_cmd",
		action = act.SwitchToWorkspace({
			name = "msys2",
			spawn = {
				args = utils.Msys2Commands(),
			},
		}),
	},
	{
		brief = "Manjaro Workspace",
		icon = "linux_manjaro",
		action = act.SwitchToWorkspace({
			name = "manjaro",
			spawn = {
				args = utils.Wsl2Commands(),
			},
		}),
	},
	{
		brief = "ToggleTerm Tab",
		icon = "custom_vim",
		action = act.SpawnCommandInNewTab({
			args = utils.Msys2Commands("-c", "nvim -c 'ToggleTerm direction=tab'"),
		}),
	},
}

for _, command in ipairs(private) do
	table.insert(commands, command)
end

return commands
