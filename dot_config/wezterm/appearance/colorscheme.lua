local wezterm = require("wezterm")

local scheme = wezterm.get_builtin_color_schemes()["tokyonight_night"]
scheme.background = "black"

return {
	color_schemes = {
		-- Override the builtin tokyonight_night scheme with our modification.
		["tokyonight_night"] = scheme,
	},
	color_scheme = "tokyonight_night",
}
