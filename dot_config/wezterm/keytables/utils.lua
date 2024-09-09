local wezterm = require("wezterm")
local act = wezterm.action

---@type table<string, LaunchCommand>
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
