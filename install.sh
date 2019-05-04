#!/bin/bash
installpath=/usr/share/tealinux
binpath=ThemeSwitcher

if [ "$EUID" -ne 0 ]
  then echo "Cannot set some parameters"; echo "Are you root?"
  exit
fi

mkdir "${installpath}"
mkdir "${installpath}/${binpath}"

echo "copying $(pwd)/theme-switcher.sh"
cp "$(pwd)/theme-switcher.desktop" "${installpath}/${binpath}"
chmod +x "${installpath}/${binpath}/theme-switcher.sh"

echo "copying $(pwd)/theme-switcher-tray.sh"
cp "$(pwd)/theme-switcher-tray.sh" "${installpath}/${binpath}"
chmod +x "${installpath}/${binpath}/theme-switcher-tray.sh"

echo "copying $(pwd)/icon/switcher-dark.png"
cp "$(pwd)/icon/switcher-dark.png" "/usr/share/pixmaps/"

echo "copying $(pwd)/icon/switcher-light.png"
cp "$(pwd)/icon/switcher-light.png" "/usr/share/pixmaps/"

echo "copying $(pwd)/theme-switcher.desktop"
cp "$(pwd)/theme-switcher.desktop" "/etc/xdg/autostart"
chmod +x "/etc/xdg/autostart/theme-switcher.desktop"

echo "done!"