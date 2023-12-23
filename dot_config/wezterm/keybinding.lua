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
		{ key = "m", mods = "CTRL", action = act.QuickSelect },

		-- Copy Mode
		{
			key = "n",
			mods = "CTRL",
			-- action = act.ActivateCopyMode
			action = wezterm.action_callback(function(window, pane)
				ActionAndChangeWindowFrameColor(window, pane, "copy_mode", act.ActivateCopyMode)
			end),
		},

		-- Paste
		{
			key = "v",
			mods = "CTRL",
			action = wezterm.action_callback(function(window, pane)
				if pane:is_alt_screen_active() then
					window:perform_action(act.SendKey({ key = "v", mods = "CTRL" }), pane)
				else
					window:perform_action(act.PasteFrom("Clipboard"), pane)
				end
			end),
		},

		-- Zellij-style keybindings
		-- CTRL + p: pane mode
		{
			key = "p",
			mods = "CTRL",
			action = wezterm.action_callback(function(window, pane)
				ActivateKeyTableAndChangeWindowFrameColor(window, pane, "pane")
			end),
		},

		-- CTRL + t: tab mode
		{
			key = "t",
			mods = "CTRL",
			action = wezterm.action_callback(function(window, pane)
				ActivateKeyTableAndChangeWindowFrameColor(window, pane, "tab")
			end),
		},

		-- CTRL + w: workspace mode
		{
			key = "w",
			mods = "CTRL",
			action = wezterm.action_callback(function(window, pane)
				ActivateKeyTableAndChangeWindowFrameColor(window, pane, "workspace")
			end),
		},
	}
end

return module
