local wezterm = require("wezterm")
local act = wezterm.action

return {
	-- Create a new pane
	{ key = "n", action = act.SplitHorizontal },
	{ key = "v", action = act.SplitVertical },

	-- Close the current pane
	{ key = "x", action = act.CloseCurrentPane({ confirm = false }) },

	-- Focus panes
	{ key = "h", action = act.ActivatePaneDirection("Left") },
	{ key = "l", action = act.ActivatePaneDirection("Right") },
	{ key = "j", action = act.ActivatePaneDirection("Down") },
	{ key = "k", action = act.ActivatePaneDirection("Up") },

	-- Resize pane
	{ key = "LeftArrow", action = act.AdjustPaneSize({ "Left", 1 }) },
	{ key = "RightArrow", action = act.AdjustPaneSize({ "Right", 1 }) },
	{ key = "UpArrow", action = act.AdjustPaneSize({ "Up", 1 }) },
	{ key = "DownArrow", action = act.AdjustPaneSize({ "Down", 1 }) },

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
