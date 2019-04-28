#!/bin/bash
file1=~/.config/tea-switcher-mode.cfg
file2=/usr/share/tealinux/ThemeSwitcher/theme-switcher.sh
if [ ! -f ${file1} ]; then
	echo 1 > ${file1}
fi
readarray -t apps < ${file1}
if [ ${apps[0]} == 0 ]; then
        kill $(pgrep yad)
        yad --notification --image="switcher-light" --command="${file2}" --text="Switch to Dark Mode" --no-middle &
        xfconf-query -c xsettings -p /Net/ThemeName -s Tea-Light
        xfconf-query -c xsettings -p /Net/IconThemeName -s Papirus
        xfconf-query -c xfwm4 -p /general/theme -s Tea-Light
        xfconf-query -c xsettings -p /Gtk/CursorThemeName -s Tea-Cursor-Dark
        echo 1 > ${file1}
else
        kill $(pgrep yad)
        yad --notification --image="switcher-dark" --command="${file2}" --text="Switch to Light Mode" --no-middle &
        xfconf-query -c xsettings -p /Net/ThemeName -s Tea-Dark
        xfconf-query -c xsettings -p /Net/IconThemeName -s Papirus-Dark
        xfconf-query -c xfwm4 -p /general/theme -s Tea-Dark
        xfconf-query -c xsettings -p /Gtk/CursorThemeName -s Tea-Cursor-Light
        echo 0 > ${file1}
fi
xfce4-panel -r
