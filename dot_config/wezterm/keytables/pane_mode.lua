local wezterm = require("wezterm")
local act = wezterm.action
local spawn = require("spawn")

return {
	-- Create a new pane
	{
		key = "v",
		action = wezterm.action_callback(function(window, pane)
			local args = {
				direction = "Right",
				command = spawn.get_spawn_command_according_to_workspace(window),
				size = { Percent = 50 },
			}
			window:perform_action(act.SplitPane(args), pane)
		end),
	},
	{
		key = "n",
		action = wezterm.action_callback(function(window, pane)
			local args = {
				direction = "Down",
				command = spawn.get_spawn_command_according_to_workspace(window),
				size = { Percent = 30 },
			}
			window:perform_action(act.SplitPane(args), pane)
		end),
	},

	-- Close the current pane
	{ key = "x", action = act.CloseCurrentPane({ confirm = false }) },

	-- Focus panes
	{ key = "h", action = act.ActivatePaneDirection("Left") },
	{ key = "l", action = act.ActivatePaneDirection("Right") },
	{ key = "j", action = act.ActivatePaneDirection("Down") },
	{ key = "k", action = act.ActivatePaneDirection("Up") },

	-- Resize pane
	{ key = "LeftArrow", action = act.AdjustPaneSize({ "Left", 2 }) },
	{ key = "RightArrow", action = act.AdjustPaneSize({ "Right", 2 }) },
	{ key = "UpArrow", action = act.AdjustPaneSize({ "Up", 2 }) },
	{ key = "DownArrow", action = act.AdjustPaneSize({ "Down", 2 }) },

	-- Move pane to full screen
	{ key = "f", action = act.Multiple({ "PopKeyTable", act.TogglePaneZoomState }) },

	-- Move pane to new tab
	{
		key = "t",
		action = wezterm.action_callback(function(_, pane)
			pane:move_to_new_tab()
		end),
	},

	-- Rotate panes
	{ key = "Space", action = act.RotatePanes("Clockwise") },
	-- Show the pane selection mode
	{ key = "s", action = act.PaneSelect({ mode = "SwapWithActive" }) },

	-- Cancel pane mode
	{ key = "Enter", action = "PopKeyTable" },
	{ key = "Escape", action = "PopKeyTable" },
}
