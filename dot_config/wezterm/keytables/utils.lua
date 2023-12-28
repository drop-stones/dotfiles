local wezterm = require("wezterm")
local act = wezterm.action

local module = {}

-- Prompt an input line and run callback
function module.PromptInputLineAndCallback(text, callback)
	return act.PromptInputLine({
		description = wezterm.format({
			{ Attribute = { Intensity = "Bold" } },
			{ Foreground = { AnsiColor = "Fuchsia" } },
			{ Text = text },
		}),
		action = wezterm.action_callback(callback),
	})
end

return module
