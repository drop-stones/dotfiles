local wezterm = require("wezterm")
local act = wezterm.action
local spawn_commands = require("spawn.spawn_commands")
local private = require("spawn.command_palette.private")

local function deepcopy(orig)
	local orig_type = type(orig)
	local copy
	if orig_type == "table" then
		copy = {}
		for orig_key, orig_value in next, orig, nil do
			copy[deepcopy(orig_key)] = deepcopy(orig_value)
		end
		setmetatable(copy, deepcopy(getmetatable(orig)))
	else -- number, string, boolean, etc
		copy = orig
	end
	return copy
end

local function AppendSpawnCommand(spawn_command, ...)
	local command = deepcopy(spawn_command) or {}
	local args = command.args or {}
	for _, arg in ipairs({ ... }) do
		table.insert(args, arg)
	end
	command.args = args
	return command
end

local function AppendCwdToSpawnCommand(spawn_command, cwd)
	local command = deepcopy(spawn_command) or {}
	command.cwd = cwd
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
			spawn = AppendCwdToSpawnCommand(spawn_commands["manjaro"], "~"),
		}),
	},
	{
		brief = "ToggleTerm Tab",
		icon = "custom_vim",
		action = wezterm.action_callback(function(window, pane)
			local workspace_name = window:active_workspace()
			local spawn_command = deepcopy(spawn_commands[workspace_name] or spawn_commands["zsh"])
			if string.find(pane:get_domain_name(), "WSL:") then
				spawn_command = AppendSpawnCommand(spawn_command, "-c", "nvim -c 'ToggleTerm direction=tab'")
			else
				if spawn_command.args[1] == "zsh" or spawn_command.args[1] == "msys2.cmd" then
					spawn_command = AppendSpawnCommand(spawn_command, "-c", "nvim -c 'ToggleTerm direction=tab'")
					-- elseif spawn_command.args[1] == "pwsh" then
					-- 	spawn_command = AppendSpawnCommand(spawn_command, "-Command", "\"nvim -c 'ToggleTerm direction=tab'\"")
				end
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
