# compton -b &
nitrogen --restore &
xset r rate 200 40
xset m 100/1 1
if xrandr | grep "DP-3 connected"; then
  sh ~/.screenlayout/work-horiz-double.sh
fi
