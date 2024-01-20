local wezterm = require("wezterm")
local module = {}

function module.deepcopy(orig)
	local orig_type = type(orig)
	local copy
	if orig_type == "table" then
		copy = {}
		for orig_key, orig_value in next, orig, nil do
			copy[module.deepcopy(orig_key)] = module.deepcopy(orig_value)
		end
		setmetatable(copy, module.deepcopy(getmetatable(orig)))
	else -- number, string, boolean, etc
		copy = orig
	end
	return copy
end

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

function module.IsWindows()
	return string.find(wezterm.target_triple, "windows") ~= nil
end

function module.IsDarwin()
	return string.find(wezterm.target_triple, "darwin") ~= nil
end

function module.IsLinux()
	return string.match(wezterm.target_triple, "linux") ~= nil
end

return module
