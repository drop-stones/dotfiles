local wezterm = require("wezterm")
local act = wezterm.action
local module = {}

function ActionAndChangeWindowFrameColor(window, pane, mode, action)
	local overrides = window:get_config_overrides() or {}
	local color
	if mode == "tab" then
		color = "#355e3b" -- Hunter green
	elseif mode == "pane" then
		color = "#000080" -- Navy blue
	elseif mode == "workspace" then
		color = "#8b0000" -- Dark red
	elseif mode == "copy_mode" then
		color = "#666666" -- Gray
	end

	if mode ~= nil then
		local window_frame = window:effective_config().window_frame
		overrides.window_frame = {
			active_titlebar_bg = window_frame.active_titlebar_bg,
			inactive_titlebar_bg = window_frame.inactive_titlebar_bg,
			border_left_width = window_frame.border_left_width,
			border_right_width = window_frame.border_right_width,
			border_bottom_height = window_frame.border_bottom_height,
			border_top_height = window_frame.border_top_height,
			border_left_color = color,
			border_right_color = color,
			border_bottom_color = color,
			border_top_color = color,
		}
	else
		overrides.window_frame = nil
	end
	window:set_config_overrides(overrides)

	window:perform_action(action, pane)
end

function ActivateKeyTableAndChangeWindowFrameColor(window, pane, mode)
	ActionAndChangeWindowFrameColor(
		window,
		pane,
		mode,
		act.ActivateKeyTable({
			name = mode,
			one_shot = false,
			replace_current = true,
			until_unknown = true,
		})
	)
end

function module.apply_to_config(config)
	config.use_ime = true

	config.keys = {
		-- Quick Select Mode
		{ key = "m", mods = "ALT", action = act.QuickSelect },

		-- Copy Mode
		{
			key = "n",
			mods = "ALT",
			action = wezterm.action_callback(function(window, pane)
				ActionAndChangeWindowFrameColor(window, pane, "copy_mode", act.ActivateCopyMode)
			end),
		},

		-- Paste
		{
			key = "v",
			mods = "ALT",
			action = wezterm.action_callback(function(window, pane)
				window:perform_action(act.SendKey({ key = "v", mods = "ALT" }), pane)
			end),
		},

		-- Zellij-style keybindings
		-- ALT + p: pane mode
		{
			key = "p",
			mods = "ALT",
			action = wezterm.action_callback(function(window, pane)
				ActivateKeyTableAndChangeWindowFrameColor(window, pane, "pane")
			end),
		},

		-- ALT + t: tab mode
		{
			key = "t",
			mods = "ALT",
			action = wezterm.action_callback(function(window, pane)
				ActivateKeyTableAndChangeWindowFrameColor(window, pane, "tab")
			end),
		},

		-- ALT + w: workspace mode
		{
			key = "w",
			mods = "ALT",
			action = wezterm.action_callback(function(window, pane)
				ActivateKeyTableAndChangeWindowFrameColor(window, pane, "workspace")
			end),
		},

		-- ALT + f: Command Palette
		{ key = "f", mods = "ALT", action = act.ActivateCommandPalette },
	}
end

return module
