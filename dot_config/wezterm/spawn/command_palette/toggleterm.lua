local wezterm = require("wezterm")
local act = wezterm.action
local utils = require("spawn.utils")
local spawn_commands = require("spawn.spawn_commands")

local function AppendSpawnCommand(spawn_command, ...)
	local command = utils.deepcopy(spawn_command) or {}
	local args = command.args or {}
	for _, arg in ipairs({ ... }) do
		table.insert(args, arg)
	end
	command.args = args
	return command
end

return {
	{
		brief = "ToggleTerm Tab",
		icon = "custom_vim",
		action = wezterm.action_callback(function(window, pane)
			local workspace_name = window:active_workspace()
			local spawn_command = utils.deepcopy(spawn_commands[workspace_name] or spawn_commands["zsh"])
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
