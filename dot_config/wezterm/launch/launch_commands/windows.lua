local windows = require("utils.command.windows")

return {
	["PowerShell"] = windows.PowerShellLaunchCommand({
		brief = "PowerShell Workspace",
	}),
	["Msys2"] = windows.Msys2LaunchCommand({
		brief = "Msys2 Workspace",
	}),
	["Arch Linux"] = windows.ArchLaunchCommand({
		brief = "Arch Workspace",
	}),
}
