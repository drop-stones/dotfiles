local private = require("spawn.command_palette.private")

local command_palette = {}

local windows = require("spawn.command_palette.windows")
for _, spawn in ipairs(windows) do
	table.insert(command_palette, spawn)
end

local unix = require("spawn.command_palette.unix")
for _, spawn in ipairs(unix) do
	table.insert(command_palette, spawn)
end

local toggleterm = require("spawn.command_palette.toggleterm")
for _, spawn in ipairs(toggleterm) do
	table.insert(command_palette, spawn)
end

-- Load spawn/private.lua
for _, spawn in ipairs(private) do
	table.insert(command_palette, spawn)
end

return command_palette
