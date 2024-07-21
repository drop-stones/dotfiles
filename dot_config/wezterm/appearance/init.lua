local wezterm = require("wezterm")
local colorscheme = require("appearance.colorscheme")
local background = require("appearance.background")
local tab = require("appearance.tab")
local window = require("appearance.window")
local private = require("appearance.private")

local module = {}

function module.apply_to_config(config)
	-- color scheme
	config.color_schemes = colorscheme.color_schemes
	config.color_scheme = colorscheme.color_scheme

	-- font
	config.font_size = 9.0

	-- background
	config.window_background_opacity = 0.7

	tab.apply_to_config(config)
	window.apply_to_config(config)
	background.apply_to_config(config)
	private.apply_to_config(config)
end

return module
