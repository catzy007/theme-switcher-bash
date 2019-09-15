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
cp "$(pwd)/theme-switcher.sh" "${installpath}/${binpath}"
chmod +x "${installpath}/${binpath}/theme-switcher.sh"

echo "copying $(pwd)/icon/switcher-dark.png"
cp "$(pwd)/icon/switcher-dark.png" "/usr/share/pixmaps/"

echo "copying $(pwd)/icon/switcher-light.png"
cp "$(pwd)/icon/switcher-light.png" "/usr/share/pixmaps/"

echo "copying $(pwd)/theme-switcher.desktop"
cp "$(pwd)/theme-switcher.desktop" "/etc/xdg/autostart"
chmod +x "/etc/xdg/autostart/theme-switcher.desktop"

echo "copying $(pwd)/tray"
cd tray
cmake .
make
cd ..
cp -r "$(pwd)/tray" "${installpath}/${binpath}"

echo "done!"
