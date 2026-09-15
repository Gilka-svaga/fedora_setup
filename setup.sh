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

echo '[+] Installing Flatpak and Microsoft fronts'
dnf install -y flatpak curl cabextract xorg-x11-font-utils
flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

rpm -i https://downloads.sourceforge.net/project/mscorefonts2/rpms/msttcore-fonts-installer-2.6-1.noarch.rpm || true
echo '[+] Success'

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
