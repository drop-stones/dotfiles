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

local spawn_commands = {
	powershell = {
		args = module.PowerShellCommands(),
	},
	msys2 = {
		args = module.Msys2Commands(),
	},
	manjaro = {
		args = module.Wsl2Commands(),
	},
	toggleterm = {
		args = module.Msys2Commands("-c", "nvim -c 'ToggleTerm direction=tab'"),
	},
}

local spawn_commands_for_palette = {
	{
		brief = "Powershell Workspace",
		icon = "cod_terminal_powershell",
		action = act.SwitchToWorkspace({
			name = "powershell",
			spawn = spawn_commands["powershell"],
		}),
	},
	{
		brief = "Msys2 Workspace",
		icon = "cod_terminal_cmd",
		action = act.SwitchToWorkspace({
			name = "msys2",
			spawn = spawn_commands["msys2"],
		}),
	},
	{
		brief = "Manjaro Workspace",
		icon = "linux_manjaro",
		action = act.SwitchToWorkspace({
			name = "manjaro",
			spawn = spawn_commands["manjaro"],
		}),
	},
	{
		brief = "ToggleTerm Tab",
		icon = "custom_vim",
		action = act.SpawnCommandInNewTab(spawn_commands["toggleterm"]),
	},
}

for key, spawn in pairs(private.spawn_commands) do
	spawn_commands[key] = spawn
end

for _, spawn in ipairs(private.spawn_commands_for_pallette) do
	table.insert(spawn_commands_for_palette, spawn)
end

function module.get_spawn_commands_for_palette()
	return spawn_commands_for_palette
end

function module.contains_spawn_command(key)
	return spawn_commands[key] ~= nil
end

function module.get_spawn_command(key)
	return spawn_commands[key]
end

return module
