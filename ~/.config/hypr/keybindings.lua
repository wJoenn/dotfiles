---------------------
---- KEYBINDINGS ----
---------------------

-- See https://wiki.hypr.land/configuring/core/binds/
-- See https://wiki.hypr.land/configuring/core/dispatchers/
local programs = require("programs")

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Manage applications
hl.bind("Super_L", hl.dsp.exec_cmd(programs.menu), { release = true })
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(programs.browser))
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd(programs.editor))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd("eww open --toggle drawer"))
hl.bind(mainMod .. " + F", hl.dsp.exec_cmd(programs.fileManager))
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(programs.terminal))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("spotify-launcher"))
hl.bind(mainMod .. " + ALT + S", hl.dsp.exec_cmd("grim - | wl-copy -t image/png"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd('grim -g "$(slurp -b 18181880 -c 80eec0)" - | wl-copy -t image/png'))
hl.bind("ALT + F4", hl.dsp.window.close())
hl.bind("F11", hl.dsp.window.fullscreen({ mode = "maximized" }))

for _, direction in ipairs({ "left", "right", "up", "down" }) do
    -- Move window with mainMod + arrow keys
    hl.bind(mainMod .. " + " .. direction, hl.dsp.window.move({ direction = direction }))
    -- Move active workspace to a monitor with mainMod + CTRL + arrow keys
    hl.bind(mainMod .. " + CTRL + " .. direction, hl.dsp.workspace.move({ monitor = direction }))
    -- Move focus with mainMod + SHIFT + arrow keys
    hl.bind(mainMod .. " + SHIFT + " .. direction, hl.dsp.focus({ direction = direction }))
end

-- Move window with mainMod + LMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })

-- Switch workspaces with mainMod + F{1-9}
-- Move active window to a workspace with mainMod + SHIFT + F{1-9}
for i = 1, 9 do
    hl.bind(mainMod .. " + F" .. i,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + F" .. i, hl.dsp.window.move({ workspace = i }))
end

-- Laptop multimedia keys for volume
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })

-- Laptop multimedia keys for LCD brightness (requires brightnessctl)
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Laptop multimedia keys for audio control (requires playerctl)
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
