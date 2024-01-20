local wezterm = require("wezterm")
local act = wezterm.action
local spawn_commands = require("spawn.spawn_commands")
local private = require("spawn.command_palette.private")

local command_palette = {
	{
		brief = "Zsh Workspace",
		icon = "cod_terminal_bash",
		action = act.SwitchToWorkspace({
			name = "zsh",
			spawn = spawn_commands["zsh"],
		}),
	},
	{
		brief = "Powershell Workspace",
		icon = "cod_terminal_powershell",
		action = act.SwitchToWorkspace({
			name = "powershell",
			spawn = spawn_commands["powershell"],
		}),
	},
	{
		brief = "Msys2 Workspace",
		icon = "cod_terminal_cmd",
		action = act.SwitchToWorkspace({
			name = "msys2",
			spawn = spawn_commands["msys2"],
		}),
	},
	{
		brief = "Manjaro Workspace",
		icon = "linux_manjaro",
		action = act.SwitchToWorkspace({
			name = "manjaro",
			spawn = spawn_commands["manjaro"],
		}),
	},
	-- {
	-- 	brief = "ToggleTerm Tab",
	-- 	icon = "custom_vim",
	-- 	action = module.get_spawn_command_according_to_workspace("msys2"),
	-- },
}

-- Load spawn/private.lua
for _, spawn in ipairs(private) do
	table.insert(command_palette, spawn)
end

return command_palette
