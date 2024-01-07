local module = {}

function module.PowerShellCommands(...)
	local args = { "pwsh.exe", "-NoLogo" }
	for _, arg in ipairs({ ... }) do
		table.insert(args, arg)
	end
	return args
end

function module.Msys2Commands(...)
	local args = { "msys2.cmd", "-mingw64", "-defterm", "-no-start", "-use-full-path", "-shell", "zsh" }
	for _, arg in ipairs({ ... }) do
		table.insert(args, arg)
	end
	return args
end

function module.Wsl2Commands(...)
	local args = { "wsl", "--distribution", "Manjaro" }
	for _, arg in ipairs({ ... }) do
		table.insert(args, arg)
	end
	return args
end

return module
