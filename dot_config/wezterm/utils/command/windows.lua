local command = require("utils.command")

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

return module
