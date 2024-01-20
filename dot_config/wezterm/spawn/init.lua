local spawn_commands = require("spawn.spawn_commands")
local command_palette = require("spawn.command_palette")

local module = {}

function module.contains_spawn_command(key)
	return spawn_commands[key] ~= nil
end

-- Get spawn comand according to the current workspace
function module.get_spawn_command_according_to_workspace(window)
	local workspace_name = window:active_workspace()
	if module.contains_spawn_command(workspace_name) == true then
		return spawn_commands[workspace_name]
	else
		return nil
	end
end

function module.get_spawn_commands_for_palette()
	return command_palette
end

return module
