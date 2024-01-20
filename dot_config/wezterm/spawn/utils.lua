local module = {}

function module.AppendCommandArgs(...)
	local args = {}
	for _, arg in ipairs({ ... }) do
		table.insert(args, arg)
	end
	return args
end

function module.ZshCommands(...)
	return module.AppendCommandArgs("zsh", ...)
end

function module.PowerShellCommands(...)
	return module.AppendCommandArgs("pwsh", "-NoLogo", ...)
end

function module.Msys2Commands(...)
	return module.AppendCommandArgs(
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
	return module.AppendCommandArgs("wsl", ...)
end

return module
