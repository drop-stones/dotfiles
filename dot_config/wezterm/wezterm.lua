-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- Load config files
local appearance = require("appearance")
appearance.apply_to_config(config)

local launch = require("launch")
launch.apply_to_config(config)

local keybinding = require("keybinding")
keybinding.apply_to_config(config)

local keytables = require("keytables")
keytables.apply_to_config(config)

-- and finally, return the configuration to wezterm
return config
