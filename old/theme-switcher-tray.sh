#!/bin/bash
file1=~/.config/tea-switcher-mode.cfg
file2=/usr/share/tealinux/ThemeSwitcher/theme-switcher.sh

if [ ! -f ${file1} ]; then
	echo 1 > ${file1}
fi

readarray -t apps < ${file1}
if [ ${apps[0]} == 0 ]; then
    yad --notification --image="switcher-dark" --command="${file2}" --text="Switch to Light Mode" --no-middle &
else
    yad --notification --image="switcher-light" --command="${file2}" --text="Switch to Dark Mode" --no-middle &
fi

#xfce4-panel -r