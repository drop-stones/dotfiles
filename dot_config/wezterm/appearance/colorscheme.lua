local wezterm = require("wezterm")
local color = require("utils.color")

local scheme = wezterm.color.get_builtin_schemes()["tokyonight_night"]
scheme.background = color.black

return {
	color_schemes = {
		-- Override the builtin tokyonight_night scheme with our modification.
		["tokyonight_night"] = scheme,
	},
	color_scheme = "tokyonight_night",
}
