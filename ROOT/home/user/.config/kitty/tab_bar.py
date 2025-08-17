import os
from kitty.fast_data_types import Screen # type: ignore
from kitty.tab_bar import DrawData, ExtraData, TabBarData, as_rgb, draw_title

BAT_PATH: str = '/sys/class/power_supply'
BATTERY_ICONS: dict[str, str] = { 'charging': '⚡︎', 'full': '', '75': '', '50': '', '25': '', 'empty': '' }
CIRCLE_ICONS: dict[str, str] = { 'active': ' ⊙ ', 'inactive': ' • ' }
ICON_FG: int = as_rgb(0x80eec0)

def get_battery_info() -> tuple[None, None] | tuple[str, int]:
  if not os.path.exists(BAT_PATH):
    return None, None

  for dev in os.listdir(BAT_PATH):
    if dev.startswith('BAT'):
      try:
        with open(f'{BAT_PATH}/{dev}/status') as f:
          status = f.read().strip()
        with open(f'{BAT_PATH}/{dev}/capacity') as f:
          percent = int(f.read().strip())
        return status, percent
      except Exception:
        return None, None

  return None, None

def get_battery_icon() -> str:
  status, percent = get_battery_info()
  if status is None or percent is None:
    return ''

  if status == 'Charging' or percent == 100:
    return f" {BATTERY_ICONS['charging']} {percent}% "
  elif percent >= 95:
    return f" {BATTERY_ICONS['full']} {percent}% "
  elif percent >= 75:
    return f" {BATTERY_ICONS['75']} {percent}% "
  elif percent >= 50:
    return f" {BATTERY_ICONS['50']} {percent}% "
  elif percent >= 25:
    return f" {BATTERY_ICONS['25']} {percent}% "
  else:
    return f" {BATTERY_ICONS['empty']} {percent}% "

def _draw_battery_icon(screen: Screen, index: int) -> int:
  if index == 1:
    battery = get_battery_icon()

    fg = screen.cursor.fg
    screen.cursor.fg = ICON_FG
    screen.draw(battery)
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
