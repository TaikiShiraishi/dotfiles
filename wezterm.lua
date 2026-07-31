-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
-- 設定の自動リロード
config.automatically_reload_config = true
-- 設定の自動リロードの通知
wezterm.on('window-config-reloaded', function(window, pane)
  wezterm.log_info 'the config was reloaded for this window!'
end)
-- scroll backline
config.scrollback_lines = 3500
-- ime
config.use_ime = true
-- exit
config.exit_behavior = 'CloseOnCleanExit'
-- color scheme
config.color_scheme = "Dracula+"
--config.color_scheme = 'AdventureTime'
-- fonts
config.font = wezterm.font(
 "HackGen Console NF",
 {
   stretch = 'Normal',
   weight = 'Regular',
   bold = false,
   italic = false,
  }
)
config.harfbuzz_features = { 'calt=0', 'clig=0', 'liga=0' }
config.text_background_opacity = 0.85
config.font_size = 16
config.cell_width = 1.0
config.line_height = 1.0
config.use_cap_height_to_scale_fallback_fonts = true
-- background opacity
config.window_background_opacity = 0.8
config.macos_window_background_blur = 20
config.window_background_gradient = {
        -- Can be "Vertical" or "Horizontal".  Specifies the direction
        -- in which the color gradient varies.  The default is "Horizontal",
        -- with the gradient going from left-to-right.
        -- Linear and Radial gradients are also supported; see the other
        -- examples below
        -- orientation = "Vertical",
        orientation = { Linear = { angle = -45.0 } },

        -- Specifies the set of colors that are interpolated in the gradient.
        -- Accepts CSS style color specs, from named colors, through rgb
        -- strings and more
        -- colors = {
        --      "#0f0c29",
        --      "#302b63",
        --      "#24243e",
        --},
        -- colors = {
        --         "#0f0c29",
        --         "#282a36",
        --         "#343746",
        --         "#3a3f52",
        --         "#343746",
        --         "#282a36",
        -- },
        -- colors = { "Inferno" },

        -- Instead of specifying `colors`, you can use one of a number of
        -- predefined, preset gradients.
        -- A list of presets is shown in a section below.
        -- preset = "Warm",
        -- preset= "Cool",

        -- Specifies the interpolation style to be used.
        -- "Linear", "Basis" and "CatmullRom" as supported.
        -- The default is "Linear".
        interpolation = "Linear",

        -- How the colors are blended in the gradient.
        -- "Rgb", "LinearRgb", "Hsv" and "Oklab" are supported.
        -- The default is "Rgb".
        blend = "Rgb",

        -- To avoid vertical color banding for horizontal gradients, the
        -- gradient position is randomly shifted by up to the `noise` value
        -- for each pixel.
        -- Smaller values, or 0, will make bands more prominent.
        -- The default value is 64 which gives decent looking results
        -- on a retina macbook pro display.
        -- noise = 64,

        -- By default, the gradient smoothly transitions between the colors.
        -- You can adjust the sharpness by specifying the segment_size and
        -- segment_smoothness parameters.
        -- segment_size configures how many segments are present.
        -- segment_smoothness is how hard the edge is; 0.0 is a hard edge,
        -- 1.0 is a soft edge.

        segment_size = 11,
        segment_smoothness = 1.0,
}
-- タイトルバーを非表示に
config.window_decorations = "RESIZE"
-- タブバーを非表示に
-- config.show_tabs_in_tab_bar = false
-- タブが一つしかない時に非表示に
config.hide_tab_bar_if_only_one_tab = true
-- タブバーを透明に
config.window_frame = {
   inactive_titlebar_bg = "none",
   active_titlebar_bg = "none",
 }
 config.window_background_gradient = {
   colors = { "#000000" },
 }

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
   local background = "#5c6d74"
   local foreground = "#FFFFFF"

   if tab.is_active then
     background = "#ae8b2d"
     foreground = "#FFFFFF"
   end

   local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "

   return {
     { Background = { Color = background } },
     { Foreground = { Color = foreground } },
     { Text = title },
   }
 end)

-- and finally, return the configuration to wezterm
return config
