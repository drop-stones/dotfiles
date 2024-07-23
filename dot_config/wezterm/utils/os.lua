local wezterm = require("wezterm")

local module = {}

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
