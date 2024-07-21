local wezterm = require("wezterm")
local color = require("utils.color")

local module = {}

function module.apply_to_config(config)
	config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"
	config.integrated_title_buttons = {}

	config.window_padding = {
		bottom = 0,
	}

	config.window_frame = {
		inactive_titlebar_bg = color.black,
		active_titlebar_bg = color.black,

		font_size = 9.0,
	}
end

return module
