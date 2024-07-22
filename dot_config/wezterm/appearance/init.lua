local background = require("appearance.background")
local colorscheme = require("appearance.colorscheme")
local font = require("appearance.font")
local tab = require("appearance.tab")
local window = require("appearance.window")
local private = require("appearance.private")

local module = {}

function module.apply_to_config(config)
	background.apply_to_config(config)
	colorscheme.apply_to_config(config)
	font.apply_to_config(config)
	tab.apply_to_config(config)
	window.apply_to_config(config)
	background.apply_to_config(config)
	private.apply_to_config(config)
end

return module
