-- Private settings
local module = {}

-- Background image settings
local background_path = ""
local background_brightness = 0.4

function module.apply_to_config(config)
	-- put your private settings here

	-- Background config
	config.background = {
		{
			source = {
				File = background_path,
			},
			repeat_x = "NoRepeat",

			hsb = { brightness = background_brightness },

			attachment = "Fixed",
		},
	}
end

return module
