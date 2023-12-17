local wezterm = require("wezterm")
local act = wezterm.action
local module = {}

-- Show which key table is active in the status area
wezterm.on("update-right-status", function(window, _)
	local name = window:active_key_table()
	if name then
		name = "TABLE: " .. name
	end
	window:set_right_status(name or "")
end)

function module.apply_to_config(config)
	-- Zellij-style keybindings
	config.keys = {
		-- CTRL + p: pane mode
		{
			key = "p",
			mods = "CTRL",
			action = act.ActivateKeyTable({
				name = "pane",
				one_shot = false,
			}),
		},

		-- CTRL + t: tab mode
		{
			key = "t",
			mods = "CTRL",
			action = act.ActivateKeyTable({
				name = "tab",
				one_shot = false,
			}),
		},

		-- CTRL + o: workspace mode
		{
			key = "o",
			mods = "CTRL",
			action = act.ActivateKeyTable({
				name = "workspace",
				one_shot = false,
			}),
		},
	}

	config.key_tables = {
		pane = {
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
		},

		tab = {
			-- Create a new pane
			{ key = "n", action = act.SpawnTab("CurrentPaneDomain") },

			-- Close the current tab
			{ key = "x", action = act.CloseCurrentTab({ confirm = false }) },

			-- Focus tabs
			{ key = "LeftArrow", action = act.ActivateTabRelative(-1) },
			{ key = "h", action = act.ActivateTabRelative(-1) },
			{ key = "RightArrow", action = act.ActivateTabRelative(1) },
			{ key = "l", action = act.ActivateTabRelative(1) },

			-- Cancel tab mode
			{ key = "Enter", action = "PopKeyTable" },
			{ key = "Escape", action = "PopKeyTable" },
		},

		workspace = {
			-- Create a new workspace
			{
				key = "n",
				action = act.Multiple({
					"PopKeyTable",
					act.PromptInputLine({
						description = wezterm.format({
							{ Attribute = { Intensity = "Bold" } },
							{ Foreground = { AnsiColor = "Fuchsia" } },
							{ Text = "Enter name for new workspace" },
						}),
						action = wezterm.action_callback(function(window, pane, line)
							-- line will be `nil` if they hit escape without entering anything
							-- An empty string if they just hit enter
							-- Or the actual line of text they wrote
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
				}),
			},

			-- Open defalt workspace (or detach)
			{
				key = "d",
				action = act.Multiple({ "PopKeyTable", act.SwitchToWorkspace({ name = "default" }) }),
			},

			-- Focus workspace
			{ key = "LeftArrow", action = act.SwitchWorkspaceRelative(-1) },
			{ key = "h", action = act.SwitchWorkspaceRelative(-1) },
			{ key = "RightArrow", action = act.SwitchWorkspaceRelative(1) },
			{ key = "l", action = act.SwitchWorkspaceRelative(1) },

			-- Open workspace manager
			{
				key = "w",
				action = act.Multiple({
					"PopKeyTable",
					act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
				}),
			},

			-- Cancel tab mode
			{ key = "Enter", action = "PopKeyTable" },
			{ key = "Escape", action = "PopKeyTable" },
		},
	}
end

return module
