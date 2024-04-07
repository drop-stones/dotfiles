local commands = require("keybinding.commands")
local modes = require("keybinding.modes")
local mouse = require("keybinding.mouse")
local private_keybindings = require("keybinding.private")

local module = {}

function module.apply_to_config(config)
	config.use_ime = true

	local keys = {}

	-- commands.lua
	for _, command in ipairs(commands) do
		table.insert(keys, command)
	end

	-- modes.lua
	for _, mode in ipairs(modes) do
		table.insert(keys, mode)
	end

	-- private.lua
	for _, private in ipairs(private_keybindings) do
		table.insert(keys, private)
	end

	config.keys = keys

	-- mouse.lua
	mouse.apply_to_config(config)
end

return module
