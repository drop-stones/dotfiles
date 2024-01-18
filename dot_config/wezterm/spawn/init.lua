local wezterm = require("wezterm")
local act = wezterm.action
local private = require("spawn.private")

local module = {}

function module.PowerShellCommands(...)
	local args = { "pwsh.exe", "-NoLogo" }
	for _, arg in ipairs({ ... }) do
		table.insert(args, arg)
	end
	return args
end

function module.Msys2Commands(...)
	local args = { "msys2.cmd", "-mingw64", "-defterm", "-no-start", "-use-full-path", "-shell", "zsh" }
	for _, arg in ipairs({ ... }) do
		table.insert(args, arg)
	end
	return args
end

function module.Wsl2Commands(...)
	local args = { "wsl", "--distribution", "Manjaro" }
	for _, arg in ipairs({ ... }) do
		table.insert(args, arg)
	end
	return args
end

local spawn_dictionary = {
	powershell = {
		brief = "Powershell Workspace",
		icon = "cod_terminal_powershell",
		action = act.SwitchToWorkspace({
			name = "powershell",
			spawn = {
				args = module.PowerShellCommands(),
			},
		}),
	},
	msys2 = {
		brief = "Msys2 Workspace",
		icon = "cod_terminal_cmd",
		action = act.SwitchToWorkspace({
			name = "msys2",
			spawn = {
				args = module.Msys2Commands(),
			},
		}),
	},
	manjaro = {
		brief = "Manjaro Workspace",
		icon = "linux_manjaro",
		action = act.SwitchToWorkspace({
			name = "manjaro",
			spawn = {
				args = module.Wsl2Commands(),
			},
		}),
	},
	toggleterm = {
		brief = "ToggleTerm Tab",
		icon = "custom_vim",
		action = act.SpawnCommandInNewTab({
			args = module.Msys2Commands("-c", "nvim -c 'ToggleTerm direction=tab'"),
		}),
	},
}

for key, spawn in pairs(private) do
	table.insert(spawn_dictionary, key)
	spawn_dictionary[key] = spawn
end

function module.get_spawn_commands()
	local spawn_commands = {}
	for _, spawn in pairs(spawn_dictionary) do
		table.insert(spawn_commands, spawn)
	end
	return spawn_commands
end

function module.contains_spawn_command(key)
	return spawn_dictionary[key] ~= nil
end

function module.get_spawn_command(key)
	return spawn_dictionary[key]
end

return module
