local wezterm = require("wezterm")
local act = wezterm.action
local utils = require("spawn.utils")
local spawn_commands = require("spawn.spawn_commands")
local private = require("spawn.command_palette.private")

local function AppendSpawnCommand(spawn_command, ...)
	local command = spawn_command or {}
	local args = command.args or {}
	for _, arg in ipairs({ ... }) do
		table.insert(args, arg)
	end
	command.args = args
	return command
end

local command_palette = {
	{
		brief = "Zsh Workspace",
		icon = "cod_terminal_bash",
		action = act.SwitchToWorkspace({
			name = "zsh",
			spawn = spawn_commands["zsh"],
		}),
	},
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
		action = wezterm.action_callback(function(window, pane)
			local workspace_name = window:active_workspace()
			local spawn_command = spawn_commands[workspace_name] or spawn_commands["zsh"]
			if spawn_command.args[1] == "zsh" or spawn_command.args[1] == "msys2.cmd" then
				spawn_command = AppendSpawnCommand(spawn_command, "-c", "nvim -c 'ToggleTerm direction=tab'")
			elseif spawn_command.args[1] == "wsl" then
				spawn_command = AppendSpawnCommand(spawn_command, "--exec", "nvim -c 'ToggleTerm direction=tab'")
				-- elseif spawn_command.args[1] == "pwsh" then
				-- 	spawn_command = AppendSpawnCommand(spawn_command, "-Command", "\"nvim -c 'ToggleTerm direction=tab'\"")
			end
			window:perform_action(act.SpawnCommandInNewTab(spawn_command), pane)
		end),
	},
}

-- Load spawn/private.lua
for _, spawn in ipairs(private) do
	table.insert(command_palette, spawn)
end

return command_palette
