local color = require("utils.color")

local module = {
	normal_mode = {
		name = "NORMAL",
		bg = color.bg_highlight,
		fg = color.fg,
	},

	copy_mode = {
		name = "COPY",
		bg = color.bg_highlight,
		fg = color.fg,
	},

	pane_mode = {
		name = "PANE",
		bg = color.blue1,
		fg = color.fg,
	},

	tab_mode = {
		name = "TAB",
		bg = color.dark_green,
		fg = color.fg,
	},

	workspace_mode = {
		name = "WORKSPACE",
		bg = color.dark_red,
		fg = color.fg_dark,
	},
}

---@return string
function module.get_current_mode(window)
	local current_mode = window:active_key_table()
	if current_mode == nil then
		return "normal_mode"
	end
	return current_mode
end

return module
