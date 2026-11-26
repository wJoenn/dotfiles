-- Refer to the wiki for more information.
-- https://wiki.hypr.land/configuring/

-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/configuring/core/autostart/
hl.on("hyprland.start", function()
    hl.exec_cmd("hyprpaper")
    hl.exec_cmd('mpvpaper eDP-1 ~/.config/hypr/video-wallpaper --mpv-options "--loop --panscan=1.0 --video-align-x=0.57"')
    hl.exec_cmd('mpvpaper DP-1 ~/.config/hypr/video-wallpaper --mpv-options "--loop --panscan=1.0 --video-align-x=-1"')
end)

----------------------
---- SOURCE FILES ----
----------------------

-- See https://wiki.hypr.land/configuring/core/#using-multiple-configuration-files
require("monitors")
require("variables")
require("keybindings")
require("windowrules")
