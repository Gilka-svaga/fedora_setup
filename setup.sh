#!/usr/bin/env bash

set -euo pipefail

echo '[+] System updating...'
dnf update -y
echo '[+] Success'

#pause after update, for connect to wifi
echo "
next programs will be install:

— Telegram
— Vesktop (Discord client)
— ONLYOFFICE
— Steam
— Sopotify



"
read -p 'Please connect to the internet and press [ENTER] to continue '

echo '[+] Installing Flatpak'
dnf install -y flatpak curl cabextract xorg-x11-font-utils
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
echo '[+] Success'


echo '[+] Installing Microsoft Core Fonts'
dnf install -y cabextract fontconfig
mkdir -p /usr/share/fonts/msfonts
cd /tmp

curl -L -s -O https://downloads.sourceforge.net/project/corefonts/the%20fonts/final/times32.exe
curl -L -s -O https://downloads.sourceforge.net/project/corefonts/the%20fonts/final/arial32.exe
curl -L -s -O https://downloads.sourceforge.net/project/corefonts/the%20fonts/final/verdan32.exe

cabextract *.exe -d /usr/share/fonts/msfonts/ > /dev/null 2>&1
chmod 644 /usr/share/fonts/msfonts/*
rm -f /tmp/*.exe

fc-cache -f
flatpak override --system --filesystem=/usr/share/fonts:ro
echo '[+] Fonts installed successfully'


PROGRAMS=(
'org.telegram.desktop'
'dev.vencord.Vesktop'
'org.onlyoffice.desktopeditors'
'com.valvesoftware.Steam'
'com.spotify.Client'
)

echo '[+] Installing Your applications'
flatpak install -y --noninteractive flathub "${PROGRAMS[@]}"
echo '[+] Success'
echo '[+] Your System is ready'
