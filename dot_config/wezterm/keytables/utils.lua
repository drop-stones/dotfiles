local wezterm = require("wezterm")
local act = wezterm.action

---@type LaunchCommand[]
local launch_commands = require("launch.launch_commands")

local module = {}

-- Prompt an input line and run callback
function module.PromptInputLineAndCallback(text, callback)
	return act.PromptInputLine({
		description = wezterm.format({
			{ Attribute = { Intensity = "Bold" } },
			{ Foreground = { AnsiColor = "Fuchsia" } },
			{ Text = text },
		}),
		action = wezterm.action_callback(callback),
	})
end

-- Override `base` spawn command with `override`
function module.OverrideSpawnComand(base, override)
	local spawn_command = base or {}
	for key, value in pairs(override) do
		spawn_command[key] = value
	end
	return spawn_command
end

-- Insert entries to list
function module.InsertEntries(tab, ...)
	for _, entry in ipairs({ ... }) do
		table.insert(tab, entry)
	end
	return tab
end

---@param window table
---@return LaunchCommand?
function module.get_spawn_command(window)
	local workspace_name = window:active_workspace()
	if launch_commands[workspace_name] ~= nil then
		return launch_commands[workspace_name].spawn
	else
		return nil
	end
end

return module
