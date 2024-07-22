local wezterm = require("wezterm")
local color = require("utils.color")

local module = {}

local scheme = wezterm.color.get_builtin_schemes()["tokyonight_night"]
scheme.background = color.black

function module.apply_to_config(config)
	config.color_schemes = {
		-- Override the builtin tokyonight_night scheme with our modification.
		["tokyonight_night"] = scheme,
	}
	config.color_scheme = "tokyonight_night"
end

return module
