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
	arch = {
		args = utils.ZshCommands("--login"), -- login shell to load /etc/profile
		domain = {
			DomainName = "WSL:Arch",
		},
	},
}

-- Load spawn/private.lua
for key, spawn in pairs(private) do
	spawn_commands[key] = spawn
end

return spawn_commands
