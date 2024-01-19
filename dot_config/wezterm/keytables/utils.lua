local wezterm = require("wezterm")
local act = wezterm.action
local spawn = require("spawn")

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

-- Get spawn comand according to the current workspace
function module.GetSpawnCommandBasedOnWorkspace(window)
	local workspace_name = window:active_workspace()
	if spawn.contains_spawn_command(workspace_name) == true then
		return spawn.get_spawn_command(workspace_name)
	else
		return nil
	end
end

-- Override `base` spawn command with `override`
function module.OverrideSpawnComand(base, override)
	local spawn_command = base or {}
	for key, value in pairs(override) do
		spawn_command[key] = value
	end
	return spawn_command
end

return module
