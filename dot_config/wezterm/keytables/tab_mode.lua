local wezterm = require("wezterm")
local act = wezterm.action
local utils = require("keytables.utils")
local spawn = require("spawn")

return {
	-- Create a new pane
	{
		key = "n",
		action = act.Multiple({
			"PopKeyTable",
			utils.PromptInputLineAndCallback("Enter name for new tab", function(window, pane, line)
				-- line will be `nil` if they hit escape without entering anything
				-- An empty string if they just hit enter
				-- Or the actual line of text they wrote
				if line then
					local spawn_command = spawn.get_spawn_command_according_to_workspace(window)
					local args = utils.OverrideSpawnComand(spawn_command, {
						label = line,
						domain = "CurrentPaneDomain",
					})
					window:perform_action(act.SpawnCommandInNewTab(args), pane)
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
					utils.PromptInputLineAndCallback(
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
}
