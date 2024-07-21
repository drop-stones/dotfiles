local module = {}

function module.enable_tab_bar(window)
	local overrides = window:get_config_overrides() or {}
	overrides.enable_tab_bar = true
	window:set_config_overrides(overrides)
end

function module.disable_tab_bar(window)
	local overrides = window:get_config_overrides() or {}
	overrides.enable_tab_bar = false
	window:set_config_overrides(overrides)
end

function module.toggle_tab_bar(window)
	local overrides = window:get_config_overrides() or {}
	local enable_tab_bar = window:effective_config().enable_tab_bar
	overrides.enable_tab_bar = not enable_tab_bar
	window:set_config_overrides(overrides)
end

return module
