local wezterm = require("wezterm")
local act = wezterm.action
local utils = require("spawn.utils")
local private = require("spawn.private")

local spawns = {
	powershell = {
		brief = "Powershell Workspace",
		icon = "cod_terminal_powershell",
		action = act.SwitchToWorkspace({
			name = "powershell",
			spawn = {
				args = utils.PowerShellCommands(),
			},
		}),
	},
	msys2 = {
		brief = "Msys2 Workspace",
		icon = "cod_terminal_cmd",
		action = act.SwitchToWorkspace({
			name = "msys2",
			spawn = {
				args = utils.Msys2Commands(),
			},
		}),
	},
	manjaro = {
		brief = "Manjaro Workspace",
		icon = "linux_manjaro",
		action = act.SwitchToWorkspace({
			name = "manjaro",
			spawn = {
				args = utils.Wsl2Commands(),
			},
		}),
	},
	toggleterm = {
		brief = "ToggleTerm Tab",
		icon = "custom_vim",
		action = act.SpawnCommandInNewTab({
			args = utils.Msys2Commands("-c", "nvim -c 'ToggleTerm direction=tab'"),
		}),
	},
}

for key, spawn in pairs(private) do
	table.insert(spawns, key)
	spawns[key] = spawn
end

return spawns
