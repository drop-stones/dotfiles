local wezterm = require("wezterm")
local act = wezterm.action
local utils = require("spawn.utils")
local spawn_commands = require("spawn.spawn_commands")

local function AppendCwdToSpawnCommand(spawn_command, cwd)
	local command = utils.deepcopy(spawn_command) or {}
	command.cwd = cwd
	return command
end

return {
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
		brief = "Arch Workspace",
		icon = "linux_archlinux",
		action = act.SwitchToWorkspace({
			name = "arch",
			spawn = AppendCwdToSpawnCommand(spawn_commands["arch"], "~"),
		}),
	},
}
