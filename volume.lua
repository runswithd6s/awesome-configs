-- Reference: https://awesome.naquadah.org/wiki/Volume_control_and_display
-- The Widget
volume_widget = widget({ type = "textbox", name = "tb_volume",
                             align = "right" })

-- Keys
volume_up = awful.key({ }, "XF86AudioRaiseVolume", function () awful.util.spawn("amixer -D pulse set Master 9%+", false) end)
volume_down = awful.key({ }, "XF86AudioLowerVolume", function () awful.util.spawn("amixer -D pulse set Master 9%-", false) end)
volume_mute = awful.key({ }, "XF86AudioMute", function () awful.util.spawn("amixer -D pulse set Master 1+ toggle", false) end)

-- Function to update widget
function update_volume(widget)
  local fd = io.popen("amixer -D pulse sget Master")
  local status = fd:read("*all")
  fd:close()
        
  local volume_value = tonumber(string.match(status, "Playback %d+ .(%d+)")) / 100

  status = string.match(status, "%[(o[^%]]*)%]")

  -- starting colour (blueish)
  local sr, sg, sb = 0x3F, 0x3F, 0xFF
  -- ending colour (red)
  local er, eg, eb = 0xFF, 0x00, 0x00

  local ir = volume_value * (er - sr) + sr
  local ig = volume_value * (eg - sg) + sg
  local ib = volume_value * (eb - sb) + sb
  interpol_colour = string.format("%.2x%.2x%.2x", ir, ig, ib)
  if string.find(status, "on", 1, true) then
    volume = " <span background='#" .. interpol_colour .. "'> ".. volume_value * 100 .. " </span>"
  else
    volume = " <span background='#" .. interpol_colour .. "'> M </span>"
  end
  widget.text = volume
end

-- Update the widget and set a timer to update
update_volume(volume_widget)
awful.hooks.timer.register(1, function () update_volume(volume_widget) end)
