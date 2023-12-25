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

-- Reset window frame if any key tables are not activated
wezterm.on("update-status", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	local name = window:active_key_table()
	if overrides.window_frame ~= nil and name == nil then
		overrides.window_frame = nil
		window:set_config_overrides(overrides)
	end
end)

local copy_mode = nil
if wezterm.gui then
	copy_mode = wezterm.gui.default_key_tables().copy_mode
	table.insert(copy_mode, {
		key = "/",
		mods = "NONE",
		action = act.Search({ CaseSensitiveString = "" }),
	})
end

local search_mode = nil
if wezterm.gui then
	search_mode = wezterm.gui.default_key_tables().search_mode
	table.insert(search_mode, {
		key = "Escape",
		mods = "NONE",
		action = act.ActivateCopyMode,
	})
end

function module.apply_to_config(config)
	-- Zellij-style keybindings
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
						-- line will be `nil` if they hit escape without entering anything
						-- An empty string if they just hit enter
						-- Or the actual line of text they wrote
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
					wezterm.action_callback(function(window, pane)
						local tab = window:active_tab()
						local tab_name = tab:get_title()
						window:perform_action(
							PromptInputLineAndCallback(
								"Enter name for the current tab (" .. tab_name .. ")",
								function(window, pane, line)
									if line then
										tab:set_title(line)
									end
								end
							),
							pane
						)
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

			-- Toggle tab bar
			{
				key = "b",
				action = wezterm.action_callback(function(window, pane)
					local overrides = window:get_config_overrides() or {}
					if not overrides.enable_tab_bar then
						local enable_tab_bar = window:effective_config().enable_tab_bar
						overrides.enable_tab_bar = not enable_tab_bar
					else
						overrides.enable_tab_bar = nil
					end
					window:set_config_overrides(overrides)
				end),
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
		},

		-- Copy mode
		copy_mode = copy_mode,

		-- Search mode
		search_mode = search_mode,
	}
end

return module
