local wezterm = require("wezterm")
local act = wezterm.action
local module = {}

-- Prompt an input line and run callback
function PromptInputLineAndCallback(text, callback)
	return act.PromptInputLine({
		description = wezterm.format({
			{ Attribute = { Intensity = "Bold" } },
			{ Foreground = { AnsiColor = "Fuchsia" } },
			{ Text = text },
		}),
		action = wezterm.action_callback(callback),
	})
end

-- Show which key table is active in the status area by color
wezterm.on("update-right-status", function(window, _)
	local name = window:active_key_table()
	local default_color = "#111111"
	local color
	if name == "tab" then
		color = "#355e3b" -- Hunter green
	elseif name == "pane" then
		color = "#000080" -- Navy blue
	elseif name == "workspace" then
		color = "#8b0000" -- Dark red
	else
		color = default_color
	end

	local dimension = window:get_dimensions()
	local width = dimension.pixel_width
	local line_text = string.rep(" ", width)

	window:set_right_status(wezterm.format({
		{ Foreground = { Color = color } },
		{ Background = { Color = color } },
		{ Text = line_text },
	}))
	window:set_left_status(wezterm.format({
		{ Foreground = { Color = color } },
		{ Background = { Color = color } },
		{ Text = line_text },
	}))
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
				replace_current = true,
				until_unknown = true,
			}),
		},

		-- CTRL + t: tab mode
		{
			key = "t",
			mods = "CTRL",
			action = act.ActivateKeyTable({
				name = "tab",
				one_shot = false,
				replace_current = true,
				until_unknown = true,
			}),
		},

		-- CTRL + w: workspace mode
		{
			key = "w",
			mods = "CTRL",
			action = act.ActivateKeyTable({
				name = "workspace",
				one_shot = false,
				replace_current = true,
				until_unknown = true,
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
			{
				key = "n",
				action = act.Multiple({
					"PopKeyTable",
					PromptInputLineAndCallback("Enter name for new tab", function(window, pane, line)
						if line then
							window:perform_action(
								act.SpawnCommandInNewTab({
									label = line,
									domain = "CurrentPaneDomain",
								}),
								pane
							)
						end
					end),
				}),
			},

			-- Close the current tab
			{ key = "x", action = act.CloseCurrentTab({ confirm = false }) },

			-- Rename the current tab
			{
				key = "r",
				action = act.Multiple({
					"PopKeyTable",
					PromptInputLineAndCallback("Enter name for the current tab", function(window, pane, line)
						if line then
							local tab = window:active_tab()
							tab:set_title(line)
						end
					end),
				}),
			},

			-- Focus tabs
			{ key = "LeftArrow", action = act.ActivateTabRelative(-1) },
			{ key = "h", action = act.ActivateTabRelative(-1) },
			{ key = "RightArrow", action = act.ActivateTabRelative(1) },
			{ key = "l", action = act.ActivateTabRelative(1) },

			-- Open tab navigator
			{
				key = "m",
				action = act.Multiple({
					"PopKeyTable",
					act.ShowTabNavigator,
				}),
			},

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
					PromptInputLineAndCallback("Enter name for new workspace", function(window, pane, line)
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
					PromptInputLineAndCallback("Enter name for the current workspace", function(window, pane, line)
						if line then
							window:perform_action(
								wezterm.mux.rename_workspace(wezterm.mux.get_active_workspace(), line),
								pane
							)
						end
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
		},
	}
end

return module
