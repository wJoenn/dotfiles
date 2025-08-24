# import os
import subprocess
from kitty.fast_data_types import Screen # type: ignore
from kitty.tab_bar import DrawData, ExtraData, TabBarData, as_rgb, draw_title

CIRCLE_ICONS: dict[str, str] = { 'active': ' ⊙ ', 'inactive': ' • ' }
ICON_FG: int = as_rgb(0x80eec0)

def _draw_battery_icon(screen: Screen, index: int) -> int:
  if index == 1:
    process = subprocess.run('/home/joenn/code/dotfiles/bin/battery_meter', capture_output=True, text=True)
    battery_meter = process.stdout.strip()

    fg = screen.cursor.fg
    screen.cursor.fg = ICON_FG
    screen.draw(f" {battery_meter} ")
    screen.cursor.fg = fg

  return screen.cursor.x

def _draw_title(
  draw_data: DrawData,
  screen: Screen,
  tab: TabBarData,
  index: int,
  is_last: bool
) -> int:
  if index != 1 or not is_last:
    is_active = getattr(tab, "is_active", False)
    icon = CIRCLE_ICONS['active'] if is_active else CIRCLE_ICONS['inactive']
    screen.draw(icon)
    draw_title(draw_data, screen, tab, index)
    screen.draw(' ')

  return screen.cursor.x

def draw_tab(
  draw_data: DrawData,
  screen: Screen,
  tab: TabBarData,
  _before: int,
  _max_title_length: int,
  index: int,
  is_last: bool,
  _extra_data: ExtraData
) -> int:
  _draw_battery_icon(screen, index)
  end = _draw_title(draw_data, screen, tab, index, is_last)

  return end
