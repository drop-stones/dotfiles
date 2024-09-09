local command = require("utils.command")
local table_util = require("utils.table")

local module = {}

function module.PowerShellCommands(...)
	return command.AppendCommandArgs("pwsh", "-NoLogo", ...)
end

function module.Msys2Commands(...)
	return command.AppendCommandArgs(
		"msys2.cmd",
		"-mingw64",
		"-defterm",
		"-no-start",
		"-use-full-path",
		"-shell",
		"zsh",
		...
	)
end

function module.Wsl2Commands(...)
	return command.AppendCommandArgs("wsl", ...)
end

---@param override LaunchCommand?
---@return LaunchCommand
function module.PowerShellLaunchCommand(override)
	local default = {
		icon = "cod_terminal_powershell",
		spawn = {
			args = module.PowerShellCommands(),
			domain = {
				DomainName = "local",
			},
		},
	}

	return table_util.extend(default, override)
end

---@param override LaunchCommand?
---@return LaunchCommand
function module.Msys2LaunchCommand(override)
	local default = {
		icon = "cod_terminal_cmd",
		spawn = {
			args = module.Msys2Commands(),
			domain = {
				DomainName = "local",
			},
		},
	}

	return table_util.extend(default, override)
end

---@param override LaunchCommand?
---@return LaunchCommand
function module.ArchLaunchCommand(override)
	local default = {
		icon = "linux_archlinux",
		spawn = {
			args = command.ZshCommands(), -- login shell to load /etc/profile
			domain = {
				DomainName = "WSL:Arch",
			},
		},
	}

	return table_util.extend(default, override)
end

return module
