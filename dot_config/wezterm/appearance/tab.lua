local wezterm = require("wezterm")
local color = require("utils.color")
local modes = require("utils.modes")
local tab = require("utils.tab")

local module = {}

-- This function returns the suggested title for a tab.
-- It prefers the title that was set via `tab:set_title()`
-- or `wezterm cli set-tab-title`, but falls back to the
-- title of the active pane in that tab.
function tab_title(tab_info)
	local title = tab_info.tab_title
	-- if the tab title is explicitly set, take that
	if title and #title > 0 then
		return title
	end

	-- TODO: remove ".exe" and arguments, base path, "cmd"
	if tab_info.active_pane.user_vars.WEZTERM_PROG ~= "" then
		return tab_info.active_pane.user_vars.WEZTERM_PROG
	end

	-- Otherwise, use the title from the active pane
	-- in that tab
	return tab_info.active_pane.title
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local background = color.bg_dark
	local foreground = color.fg

	if tab.is_active then
		background = color.bg
		foreground = color.fg
	elseif hover then
		background = color.bg_highlight
		foreground = color.fg
	end

	local title = tab_title(tab)

	if title == nil then
		return
	end

	return wezterm.format({
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
	})
end)

function module.update_tab_bar(window, pane)
	local cells = {}

	local cwd_uri = pane:get_current_working_dir()
	if cwd_uri then
		local cwd = cwd_uri.file_path
		table.insert(cells, cwd)
	end

	-- Active Workspace
	table.insert(cells, window:active_workspace())

	-- Mode
	local mode = modes[modes.get_current_mode(window)]
	table.insert(cells, mode.name)

	-- The filled in variant of the < symbol
	local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider

	-- Foreground color for the text across the fade
	local text_fg = mode.fg

	local background_colors = {
		color.bg_dark,
		color.merge(color.bg_dark, mode.bg, 0.5, 0.5),
		mode.bg,
	}

	-- The elements to be formatted
	local elements = {}
	-- How many cells have been formatted
	local num_cells = 0

	-- Translate a cell into elements
	local function push(text)
		local cell_no = num_cells + 1
		table.insert(elements, { Foreground = { Color = background_colors[cell_no] } })
		if cell_no == 1 then
			table.insert(elements, { Background = { Color = color.black } })
		else
			table.insert(elements, { Background = { Color = background_colors[cell_no - 1] } })
		end
		table.insert(elements, { Text = SOLID_LEFT_ARROW })
		table.insert(elements, { Foreground = { Color = text_fg } })
		table.insert(elements, { Background = { Color = background_colors[cell_no] } })
		table.insert(elements, { Text = " " .. text .. "  " })
		num_cells = num_cells + 1
	end

	while #cells > 0 do
		local cell = table.remove(cells, 1)
		push(cell)
	end

	window:set_right_status(wezterm.format(elements))
end

wezterm.on("update-status", function(window, pane)
	module.update_tab_bar(window, pane)

	local mode = modes.get_current_mode(window)
	if mode == "normal_mode" then
		tab.disable_tab_bar(window)
	end
end)

function module.apply_to_config(config)
	config.enable_tab_bar = true
	config.show_new_tab_button_in_tab_bar = false
end

return module
