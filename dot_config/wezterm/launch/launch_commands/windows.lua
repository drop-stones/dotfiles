local command = require("utils.command")
local windows = require("utils.command.windows")

return {
	["PowerShell"] = {
		brief = "PowerShell Workspace",
		icon = "cod_terminal_powershell",
		spawn = { args = windows.PowerShellCommands() },
	},
	["Msys2"] = {
		brief = "Msys2 Workspace",
		icon = "cod_terminal_cmd",
		spawn = { args = windows.Msys2Commands() },
	},
	["Arch Linux"] = {
		brief = "Arch Workspace",
		icon = "linux_archlinux",
		spawn = {
			args = command.ZshCommands("--login"), -- login shell to load /etc/profile
			domain = {
				DomainName = "WSL:Arch",
			},
		},
		startup_cwd = "~",
	},
}
