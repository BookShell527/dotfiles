local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")

local math, string, os = math, string, os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome"
theme.background = '#1f2227'
theme.foreground = '#abb2bf'
theme.black = '#282c34'
theme.red = '#e06c75'
theme.green = '#98c379'
theme.yellow = '#e5c07b'
theme.blue = '#61afef'
theme.magenta = '#d16d9e'
theme.cyan = '#56b6c2'
theme.font                                      = "Iosevka 10"
theme.taglist_font                              = "Iosevka 12"
theme.fg_normal                                 = theme.green
theme.fg_focus                                  = theme.foreground
theme.fg_urgent                                 = theme.foreground
theme.bg_normal                                 = theme.background
theme.bg_focus                                  = theme.blue
theme.bg_urgent                                 = theme.red 
theme.taglist_fg_empty                          = theme.foreground
theme.taglist_fg_focus                          = theme.blue
theme.taglist_bg_focus                          = theme.background
theme.taglist_fg_occupied                       = theme.magenta
theme.taglist_fg_urgent                         = theme.red
theme.taglist_bg_urgent                         = theme.background
theme.border_width                              = 1
theme.border_normal                             = theme.background
theme.border_focus                              = theme.blue
theme.border_marked                             = theme.green
theme.titlebar_bg_focus                         = theme.background
theme.titlebar_bg_normal                        = theme.background
theme.titlebar_bg_focus                         = theme.bg_focus
theme.titlebar_bg_normal                        = theme.bg_normal
theme.titlebar_fg_focus                         = theme.fg_focus
theme.useless_gap                               = 5

return theme
