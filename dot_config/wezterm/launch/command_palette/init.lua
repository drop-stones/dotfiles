local wezterm = require("wezterm")
local act = wezterm.action
local private = require("launch.command_palette.private")

---@type LaunchCommand[]
local launch_commands = require("launch.launch_commands")

---@class CommandPaletteElement
---@field brief string
---@field icon string
---@field action function

---@alias CommandPalette CommandPaletteElement[]

---@type CommandPalette
local command_palette = {}

for name, launch_command in pairs(launch_commands) do
	local spawn = launch_command.spawn
	if launch_command.startup_cwd ~= nil then
		spawn.cwd = launch_command.startup_cwd
	end

	---@type CommandPaletteElement
	local command = {
		brief = launch_command.brief,
		icon = launch_command.icon,
		action = act.SwitchToWorkspace({
			name = name,
			spawn = spawn,
		}),
	}

	table.insert(command_palette, command)
end

for _, command in pairs(private) do
	table.insert(command_palette, command)
end

return command_palette
