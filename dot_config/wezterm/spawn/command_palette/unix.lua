local wezterm = require("wezterm")
local act = wezterm.action
local spawn_commands = require("spawn.spawn_commands")

return {
	{
		brief = "Zsh Workspace",
		icon = "cod_terminal_bash",
		action = act.SwitchToWorkspace({
			name = "zsh",
			spawn = spawn_commands["zsh"],
		}),
	},
}
