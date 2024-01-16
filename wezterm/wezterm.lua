-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

config.color_scheme = "Tokyo Night"
config.font = wezterm.font_with_fallback({
	"MonoLisa Variable",
	"Fira Code",
})

config.window_frame = {
	font = wezterm.font({ family = "MonoLisaVariable Nerd Font", weight = "Bold" }),

	font_size = 12.0,

	active_titlebar_bg = "#0e0e14",

	inactive_titlebar_bg = "#0e0e14",
}

config.colors = {
	tab_bar = {
		inactive_tab_edge = "#0e0e14",

		active_tab = {
			bg_color = "#1a1b26",
			fg_color = "#c0caf5",
		},

		inactive_tab = {
			bg_color = "#16161e",
			fg_color = "#3b4261",
		},

		inactive_tab_hover = {
			bg_color = "#1a1b26",
			fg_color = "#c0caf5",

			italic = true,
		},

		new_tab = {
			bg_color = "#16161e",
			fg_color = "#3b4261",
		},

		new_tab_hover = {
			bg_color = "#16161e",
			fg_color = "#c0caf5",
			italic = true,
		},
	},
}

-- and finally, return the configuration to wezterm
return config
