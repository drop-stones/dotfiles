local wezterm = require("wezterm")

-- https://github.com/folke/tokyonight.nvim/blob/main/extras/lua/tokyonight_night.lua
-- https://github.com/folke/tokyonight.nvim/blob/main/extras/wezterm.lua
local scheme = wezterm.color.get_builtin_schemes()["tokyonight_night"]

local module = {
	black = "#000000",
	dark = scheme.ansi[1],
	red = scheme.ansi[2],
	dark_red = "#914c54",
	green = scheme.ansi[3],
	dark_green = "#005f5f",
	yellow = scheme.ansi[4],
	blue = scheme.ansi[5],
	blue1 = "#3d59a1",
	dark_blue = "#394b70",
	magenta = scheme.ansi[6],
	cyan = scheme.ansi[7],
	grey = scheme.ansi[8],
	fg = scheme.foreground,
	fg_dark = "#a9b1d6",
	bg = scheme.background,
	bg_dark = scheme.tab_bar.inactive_tab_edge,
	bg_highlight = scheme.tab_bar.inactive_tab.bg_color,
}

---@param hex string
---@return number?, number?, number?
local function hex2rgb(hex)
	hex = hex:gsub("#", "")
	return tonumber("0x" .. hex:sub(1, 2)), tonumber("0x" .. hex:sub(3, 4)), tonumber("0x" .. hex:sub(5, 6))
end

---@param r number
---@param g number
---@param b number
---@return string
local function rgb2hex(r, g, b)
	local str_r = string.format("%02x", r)
	local str_g = string.format("%02x", g)
	local str_b = string.format("%02x", b)
	return "#" .. str_r .. str_g .. str_b
end

---@param lhs string
---@param rhs string
---@param lhs_ratio number
---@param rhs_ratio number
---@return string
function module.merge(lhs, rhs, lhs_ratio, rhs_ratio)
	local lhs_r, lhs_g, lhs_b = hex2rgb(lhs)
	local rhs_r, rhs_g, rhs_b = hex2rgb(rhs)
	lhs_r, lhs_g, lhs_b = lhs_r * lhs_ratio, lhs_g * lhs_ratio, lhs_b * lhs_ratio
	rhs_r, rhs_g, rhs_b = rhs_r * rhs_ratio, rhs_g * rhs_ratio, rhs_b * rhs_ratio

	local r, g, b = math.floor(lhs_r + rhs_r), math.floor(lhs_g + rhs_g), math.floor(lhs_b + rhs_b)
	return rgb2hex(r, g, b)
end

return module
