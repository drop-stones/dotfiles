local wezterm = require("wezterm")
local act = wezterm.action
local utils = require("keytables.utils")

return {
	-- Create a new workspace
	{
		key = "n",
		action = act.Multiple({
			"PopKeyTable",
			utils.PromptInputLineAndCallback("Enter name for new workspace", function(window, pane, line)
				if line then
					window:perform_action(
						act.SwitchToWorkspace({
							name = line,
						}),
						pane
					)
				end
			end),
		}),
	},

	-- Open defalt workspace (or detach)
	{
		key = "d",
		action = act.Multiple({ "PopKeyTable", act.SwitchToWorkspace({ name = "default" }) }),
	},

	-- Rename the current workspace
	{
		key = "r",
		action = act.Multiple({
			"PopKeyTable",
			wezterm.action_callback(function(window, pane)
				local workspace_name = window:active_workspace()
				window:perform_action(
					PromptInputLineAndCallback(
						"Enter name for the current workspace (" .. workspace_name .. ")",
						function(window, pane, line)
							if line then
								window:perform_action(
									wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line),
									pane
								)
							end
						end
					),
					pane
				)
			end),
		}),
	},

	-- Focus workspace
	{ key = "LeftArrow", action = act.SwitchWorkspaceRelative(-1) },
	{ key = "h", action = act.SwitchWorkspaceRelative(-1) },
	{ key = "RightArrow", action = act.SwitchWorkspaceRelative(1) },
	{ key = "l", action = act.SwitchWorkspaceRelative(1) },

	-- Open workspace manager
	{
		key = "m",
		action = act.Multiple({
			"PopKeyTable",
			act.ShowLauncherArgs({ flags = "WORKSPACES" }),
		}),
	},

	-- Cancel tab mode
	{ key = "Enter", action = "PopKeyTable" },
	{ key = "Escape", action = "PopKeyTable" },
}
