local utils_os = require("utils.os")
local windows = require("launch.launch_commands.windows")
local private = require("launch.launch_commands.private")

---@class LaunchCommand
---@field brief string? brief explanation
---@field icon string icon name
---@field spawn table SpawnCommand
---@field startup_cwd string? Working directory at startup of workspace

---@type LaunchCommand[]
local launch_commands = {}

if utils_os.IsWindows() then
	for key, command in pairs(windows) do
		launch_commands[key] = command
	end
end

for key, command in pairs(private) do
	launch_commands[key] = command
end

return launch_commands
