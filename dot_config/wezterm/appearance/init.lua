local wezterm = require("wezterm")
local colorscheme = require("appearance.colorscheme")
local background = require("appearance.background")
local private = require("appearance.private")

local module = {}

local function FormatNvimTitle(s)
	s = string.gsub(s, "%s%(.*%)", "") -- remove "(path/to/directory)"
	s = string.gsub(s, "%s%-%sNVIM", " - nvim") -- replace "NVIM" to "nvim"
	return s
end

local function BaseName(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local nvim_formatted_title = FormatNvimTitle(tab.active_pane.title)
	local title = BaseName(nvim_formatted_title)
	return {
		{ Text = title },
	}
end)

wezterm.on("format-window-title", function(tab)
	return BaseName(tab.action_pane.foreground_process_name)
end)

function module.apply_to_config(config)
	-- color scheme
	config.color_schemes = colorscheme.color_schemes
	config.color_scheme = colorscheme.color_scheme

	-- font
	config.font_size = 10.5

	-- background
	config.window_background_opacity = 0.7

	-- window
	config.window_decorations = "INTEGRATED_BUTTONS | RESIZE"

	-- tab
	config.hide_tab_bar_if_only_one_tab = true
	config.enable_tab_bar = false
	config.tab_bar_at_bottom = true
	config.window_frame = {
		active_titlebar_bg = "#111111",
		inactive_titlebar_bg = "#111111",
		border_left_width = "0.25cell",
		border_right_width = "0.25cell",
		border_bottom_height = "0.125cell",
		border_top_height = "0.125cell",
	}

	-- background
	config.background = {
		{
			source = {
				File = background.background_path,
			},
			repeat_x = background.repeat_x,

			hsb = { brightness = background.background_brightness },

			attachment = background.attachment,
		},
	}

	private.apply_to_config(config)
end

return module
