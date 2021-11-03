local gears = require("gears")
local lain  = require("lain")
local awful = require("awful")
local wibox = require("wibox")

local math, string, os = math, string, os
local my_table = awful.util.table or gears.table -- 4.{0,1} compatibility

local theme                                     = {}
theme.dir                                       = os.getenv("HOME") .. "/.config/awesome"
theme.background = '#282C34'
theme.foreground = '#BBC2CF'
theme.black = '#1C1F24'
theme.red = '#FF6C6B'
theme.green = '#98BE65'
theme.yellow = '#DA8548'
theme.blue = '#51AFEF'
theme.magenta = '#C678DD'
theme.cyan = '#5699AF'
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
