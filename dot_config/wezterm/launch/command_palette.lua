local wezterm = require("wezterm")
local act = wezterm.action
local spawns = require("spawn")

local commands = {}

for _, spawn in pairs(spawns) do
	table.insert(commands, spawn)
end

return commands
