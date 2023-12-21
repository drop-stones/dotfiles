local wezterm = require("wezterm")
local module = {}

local function FormatNvimTitle(s)
	s = string.gsub(s, "%s%(.*%)", "") -- remove "(path/to/directory)"
	s = string.gsub(s, "%s%-%sNVIM", " - nvim") -- replace "NVIM" to "nvim"
	return s
end

local function BaseName(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

function module.apply_to_config(config)
	-- color scheme
	config.color_scheme = "Builtin Dark"

	-- font
	config.font_size = 12.5

	-- background
	config.window_background_opacity = 0.7

	-- window
	config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"
	wezterm.on("format-window-title", function(tab)
		return BaseName(tab.action_pane.foreground_process_name)
	end)

	-- tab
	config.window_frame = {
		font_size = 1.2,
		active_titlebar_bg = "#111111",
		inactive_titlebar_bg = "#111111",
	}
	config.enable_tab_bar = true
	config.tab_bar_at_bottom = true
	config.integrated_title_buttons = {}
	config.show_tabs_in_tab_bar = false
	config.show_new_tab_button_in_tab_bar = false

	-- scrollbar
	wezterm.on("update-status", function(window, pane) -- if in nvim then hide the scrollbar
		local overrides = window:get_config_overrides() or {}
		if pane:is_alt_screen_active() then
			overrides.enable_scroll_bar = false
		else
			overrides.enable_scroll_bar = true
		end
		window:set_config_overrides(overrides)
	end)

	-- process name in tab title
	-- wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	-- 	local SYMBOL_COLOR = { "#ffb2cc", "#a4a4a4" }
	-- 	local FONT_COLOR = { "#dddddd", "#888888" }
	-- 	local BACK_COLOR = { "#2d2d2d" }
	-- 	local HOVER_COLOR = { "#434343" }
	--
	-- 	local index = tab.is_active and 1 or 2
	--
	-- 	local bg = hover and HOVER_COLOR or BACK_COLOR
	--
	-- 	return {
	-- 		{ Foreground = { Color = SYMBOL_COLOR[index] } },
	-- 		{ Background = { Color = bg } },
	-- 		{ Text = tab.active_pane.title },
	--
	-- 		{ Foreground = { Color = FONT_COLOR[index] } },
	-- 		{ Background = { Color = bg } },
	-- 		{ Text = tab.active_pane.title },
	-- 	}
	-- end)

	-- wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	-- 	local title = wezterm.truncate_right(utils.basename(tab.active_pane.foreground_process_name), max_width)
	-- 	if title == "" then
	-- 		title = wezterm.truncate_right(
	-- 			utils.basename(utils.convert_home_dir(tab.active_pane.current_working_dir)),
	-- 			max_width
	-- 		)
	-- 	end
	-- 	return {
	-- 		{ Text = tab.tab_index + 1 .. ":" .. title },
	-- 	}
	-- end)
end

return module
