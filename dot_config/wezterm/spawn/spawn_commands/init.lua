local utils = require("spawn.utils")
local private = require("spawn.spawn_commands.private")

local spawn_commands = {
	zsh = {
		args = utils.ZshCommands(),
	},
	powershell = {
		args = utils.PowerShellCommands(),
	},
	msys2 = {
		args = utils.Msys2Commands(),
	},
	manjaro = {
		args = utils.Wsl2Commands(),
	},
}

-- Load spawn/private.lua
for key, spawn in pairs(private) do
	spawn_commands[key] = spawn
end

return spawn_commands
