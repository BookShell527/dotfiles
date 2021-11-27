pcall(require, "luarocks.loader")
local gears = require("gears")
local awful = require("awful")
local wibox = require("wibox")
local beautiful = require("beautiful")
local freedesktop = require("freedesktop")
local lain = require("lain")
local api = require("api")
require("awful.autofocus")

local math, string, os = math, string, os
local my_table = awful.util.table or gears.table

do
  local in_error = false
  awesome.connect_signal("debug::error", function (err)
    if in_error then return end
    in_error = false
  end)
end

beautiful.init("/home/tempp/.config/awesome/theme.lua")
local terminal = "alacritty"
local rofi_dir = "sh /home/tempp/.config/rofi/bin/"
local modkey = "Mod4"

mymainmenu = freedesktop.menu.build({
    icon_size = 16,
    after = {
        { "Terminal", terminal },
        { "Log out", function() awesome.quit() end },
        { "Sleep", "systemctl suspend" },
        { "Restart", "systemctl reboot" },
        { "Exit", "systemctl poweroff" },
    }
})

local markup = lain.util.markup
local separators = lain.util.separators

-- Textclock
local clock = awful.widget.watch("date +'%a %d %b %R'", 60, function(widget, stdout)
    widget:set_markup(
        markup.fontfg(beautiful.font, beautiful.yellow, " " .. stdout)
    )
end)

-- MEM
local mem = lain.widget.mem({
    settings = function()
      widget:set_markup(
        markup.fontfg(beautiful.font, beautiful.red, " " .. mem_now.used .. "MB ")
      )
    end
})

-- CPU
local cpu = lain.widget.cpu({
    settings = function()
      widget:set_markup(
        markup.fontfg(beautiful.font, beautiful.magenta, " " .. cpu_now.usage .. "% ")
      )
    end
})

-- Battery
local bat = lain.widget.bat({
    settings = function()
        if bat_now.status and bat_now.status ~= "N/A" then
            if bat_now.ac_status == 1 then
              widget:set_markup(markup.fontfg(beautiful.font, beautiful.blue, " "  .. bat_now.perc .. "% "))
              return
            else
              widget:set_markup(markup.fontfg(beautiful.font, beautiful.blue, " " .. bat_now.perc .. "% "))
            end
        else
          widget:set_markup()
        end
    end
})

-- ALSA volume
local volume = lain.widget.alsa({
    settings = function()
        if volume_now.status == "off" then
          widget:set_markup(markup.fontfg(beautiful.font, beautiful.blue, "婢 " .. volume_now.level .. "% "))
        elseif tonumber(volume_now.level) == 0 then
          widget:set_markup(markup.fontfg(beautiful.font, beautiful.blue, "奄 " .. volume_now.level .. "% "))
        elseif tonumber(volume_now.level) <= 50 then
          widget:set_markup(markup.fontfg(beautiful.font, beautiful.blue, "奔 " .. volume_now.level .. "% "))
        else
          widget:set_markup(markup.fontfg(beautiful.font, beautiful.blue, " " .. volume_now.level .. "% "))
        end
    end
})

-- Net
local net = lain.widget.net({
    settings = function()
      widget:set_markup(
        markup.fontfg(beautiful.font, beautiful.cyan, "直 " .. net_now.received .. "↓↑" .. net_now.sent .. " ")
      )
    end
})
net.widget:buttons(
  gears.table.join(
    awful.button({ }, 1, function()
        awful.spawn("nmd")
    end),
    awful.button({ }, 3, function()
        awful.spawn("nmd")
    end)
  )
)

-- Weather
local weather = lain.widget.weather({
    APPID = api,
    city_id = 1625822,
    weather_na_markup = markup.fontfg(beautiful.font, beautiful.cyan, "N/A "),
    settings = function ()
        descr = weather_now["weather"][1]["description"]:lower()
        units = math.floor(weather_now["main"]["temp"])
        widget:set_markup(markup.fontfg(beautiful.font, beautiful.cyan, descr .. " " .. units .. "°C "))
    end
})

function at_screen_connect(s)
    -- awful.tag({ " א ", " 二 ", " ג ", " 四 ", " ה ", " 六 ", " ז ", " 八 ", " ט " }, s, awful.layout.layouts[1])
    awful.tag({ "I", " II ", "III", " IV ", "V", " VI ", "VII", " VIII ", "IX " }, s, awful.layout.layouts[1])
    -- awful.tag({ "", "  ", "", "  ", "", "  ", "", "  ", " " }, s, awful.layout.layouts[1])

    s.mytaglist = awful.widget.taglist(
      s,
      awful.widget.taglist.filter.all,
      gears.table.join(
        awful.button({  }, 1, function(t)
            t:view_only()
        end),
        awful.button({}, 3, awful.tag.viewtoggle)
      )
    )
    s.mylayoutbox = awful.widget.layoutbox(s)
    s.mylayoutbox:buttons(gears.table.join(
        awful.button({}, 1, function ()
            awful.layout.inc(1)
        end),
        awful.button({}, 3,
          function ()
            awful.layout.inc(-1)
        end)
    ))
    s.mywibox = awful.wibar({
        position = "top",
        screen = s,
        height = 24,
        bg = beautiful.bg_normal,
        fg = beautiful.fg_normal
    })
    s.mywibox:setup {
        layout = wibox.layout.align.horizontal,
        expand = "none",
        {
            layout = wibox.layout.fixed.horizontal,
            wibox.widget.textbox(" ["), s.mylayoutbox, wibox.widget.textbox("] "),
            s.mytaglist,
            wibox.widget.systray(),
        },
        {
            layout = wibox.layout.fixed.horizontal,
            wibox.container.background(wibox.container.margin(weather.widget, 0, 0), beautiful.background),
        },
        {
            layout = wibox.layout.fixed.horizontal,
            wibox.container.background(wibox.container.margin(volume.widget, 3, 3), beautiful.background),
            wibox.container.background(wibox.container.margin(mem.widget, 3, 3),    beautiful.background),
            wibox.container.background(wibox.container.margin(cpu.widget, 3, 3),    beautiful.background),
            wibox.container.background(wibox.container.margin(bat.widget, 3, 3),    beautiful.background),
            wibox.container.background(wibox.container.margin(net.widget, 3, 3),    beautiful.background),
            wibox.container.background(wibox.container.margin(clock, 3, 3),         beautiful.background),
        },
    }
end

awful.layout.layouts = {
    awful.layout.suit.tile,
    awful.layout.suit.tile.bottom,
    awful.layout.suit.fair,
    awful.layout.suit.spiral,
    awful.layout.suit.max,
    awful.layout.suit.floating,
}
awful.mouse.snap.edge_enabled = false
awful.screen.connect_for_each_screen(
  function(s) at_screen_connect(s)
end)

root.buttons(gears.table.join(
    awful.button({ }, 3, function() mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewnext),
    awful.button({ }, 5, awful.tag.viewprev)
))

globalkeys = gears.table.join(
    awful.key({ modkey,           }, "j", function () awful.client.focus.byidx( 1) end),
    awful.key({ modkey,           }, "k", function () awful.client.focus.byidx(-1) end),
    awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1) end),
    awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1) end),

    -- Standard program
    awful.key({ modkey,           }, "Return",  function () awful.spawn(terminal)                       end),
    awful.key({ modkey,           }, "b",       function () awful.spawn("brave-nightly")                end),
    awful.key({ modkey,           }, "c",       function () awful.spawn("color-gpick")                  end),
    awful.key({ modkey, "Shift"   }, "e",       function () awful.spawn("pcmanfm")                      end),
    awful.key({ modkey, "Shift"   }, "w",       function () awful.spawn("nitrogen")                     end),
    awful.key({ modkey,           }, "a",       function () awful.spawn("chromium teams.microsoft.com") end),
    awful.key({ modkey,           }, "e",       function () awful.spawn(terminal .. " -e lfrun")        end),
    awful.key({ modkey,           }, "o",       function () awful.spawn(terminal .. " -e gotop")        end),
    awful.key({ modkey, "Mod1"    }, "e",       function () awful.spawn("emacsclient -c")               end),

    -- Rofi program
    awful.key({ modkey,           }, "d",       function () awful.spawn(rofi_dir .. "launcher")     end),
    awful.key({ modkey,           }, "w",       function () awful.spawn(rofi_dir .. "windows")      end),
    awful.key({ modkey, "Shift"   }, "x",       function () awful.spawn(rofi_dir .. "powermenu")    end),
    awful.key({ modkey, "Shift"   }, "n",       function () awful.spawn(rofi_dir .. "network")      end),
    awful.key({ modkey,           }, "t",       function () awful.spawn(rofi_dir .. "themes")       end),
    awful.key({ modkey,           }, "n",       function () awful.spawn("nmd")                      end),
    awful.key({                   }, "Print",   function () awful.spawn(rofi_dir .. "screenshot")   end),
    awful.key({                   }, "F1",      function () awful.spawn("help-and-tips")            end),

    -- Screen lock
    awful.key({ "Mod1", "Control" }, "l", function () awful.spawn("/home/tempp/.config/awesome/bin/bsplock") end),

    -- Restart and quit
    awful.key({ modkey, "Shift"   }, "r", awesome.restart   ),
    awful.key({ modkey, "Shift"   }, "q", awesome.quit      ),

    -- Volume and Brightness control
    awful.key({}, "XF86MonBrightnessUp",    function () awful.spawn("brightness --inc")     end),
    awful.key({}, "XF86MonBrightnessDown",  function () awful.spawn("brightness --dec")     end),
    awful.key({}, "XF86AudioRaiseVolume",   function () awful.spawn("volume --inc")         end),
    awful.key({}, "XF86AudioLowerVolume",   function () awful.spawn("volume --dec")         end),
    awful.key({}, "XF86AudioMute",          function () awful.spawn("volume --toggle")      end),

    -- Mpd control
    awful.key({}, "XF86AudioNext", function () awful.spawn("playerctl --player=spotify,chromium,mpv,%any next") end),
    awful.key({}, "XF86AudioPlay", function () awful.spawn("playerctl --player=spotify,chromium,mpv,%any play-pause") end),
    awful.key({}, "XF86AudioPrev", function () awful.spawn("playerctl --player=spotify,chromium,mpv,%any previous") end),

    -- Change layout and master size
    awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)    end),
    awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)    end),
    awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)          end),
    awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)          end)
)

clientkeys = gears.table.join(
    awful.key({ modkey,          }, "f", function (c)
        c.fullscreen = not c.fullscreen
        c:raise()
    end),
    awful.key({ modkey, "Shift"   }, "c",   function (c) c:kill()        end),
    awful.key({ modkey,           }, "s",   awful.client.floating.toggle    )
)

for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys,
        awful.key({ modkey }, "#" .. i + 9, function ()
                local screen = awful.screen.focused()
                local tag = screen.tags[i]
                if tag then tag:view_only() end
        end),
        awful.key({ modkey, "Shift" }, "#" .. i + 9, function ()
            if client.focus then
              local tag = client.focus.screen.tags[i]
              if tag then client.focus:move_to_tag(tag) end
            end
        end)
    )
end

clientbuttons = gears.table.join(
    awful.button({ }, 1, function (c) c:emit_signal("request::activate", "mouse_click", {raise = true}) end),
    awful.button({ modkey }, 1, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.move(c)
    end),
    awful.button({ modkey }, 3, function (c)
        c:emit_signal("request::activate", "mouse_click", {raise = true})
        awful.mouse.client.resize(c)
    end)
)

root.keys(globalkeys)

awful.rules.rules = {
    {
        rule = { },
        properties = {
          border_width = beautiful.border_width,
          border_color = beautiful.border_normal,
          focus = awful.client.focus.filter,
          raise = true,
          keys = clientkeys,
          buttons = clientbuttons,
          screen = awful.screen.preferred,
          placement = awful.placement.no_overlap+awful.placement.no_offscreen}
        },
    {
        rule_any = {
            instance = {
              "DTA",
              "copyq",
              "pinentry"
            },
            class = {
              "Arandr",
              "Gpick",
              "Galculator",
              "Tor Browser",
              "veromix"
            },
            name = {"Event Tester"},
            role = {
              "AlarmWindow",
              "ConfigManager",
              "pop-up"
            }
        },
        properties = {
            floating = true
        }
    },
    {
      rule_any = {
        type = {
          "normal",
          "dialog"
        }
      },
      properties = {  }
    },
}

client.connect_signal("manage", function (c)
    if awesome.startup
      and not c.size_hints.user_position
      and not c.size_hints.program_position
    then
      awful.placement.no_offscreen(c)
    end
end)
client.connect_signal("mouse::enter", function(c)
    c:emit_signal("request::activate", "mouse_enter", {raise = false})
end)
client.connect_signal("focus", function(c)
    c.border_color = beautiful.border_focus
end)
client.connect_signal("unfocus", function(c)
    c.border_color = beautiful.border_normal
end)

awful.util.spawn("/home/tempp/.config/awesome/startup")
