local module = {}

function module.apply_to_config(config)
	-- color scheme
	config.color_scheme = "Builtin Dark"

	-- background
	config.window_background_opacity = 0.8

	-- window
	config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"
end

return module
