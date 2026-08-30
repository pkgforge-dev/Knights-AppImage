#!/bin/sh

set -eu

ARCH=$(uname -m)
VERSION=$(pacman -Q knights | awk '{print $2; exit}')
export ARCH VERSION
export OUTPATH=./dist
export ADD_HOOKS="self-updater.hook"
export UPINFO="gh-releases-zsync|${GITHUB_REPOSITORY%/*}|${GITHUB_REPOSITORY#*/}|latest|*$ARCH.AppImage.zsync"
export ICON=/usr/share/icons/hicolor/64x64/apps/knights.png
export DESKTOP=/usr/share/applications/org.kde.knights.desktop
export STARTUPWMCLASS=org.kde.knights
export USE_HOST_DRIVERS_EXPERIMENTAL=1

# Deploy dependencies
quick-sharun /usr/bin/knights /usr/bin/gnuchessu /usr/bin/gnuchessx /usr/bin/gnuchess

# Turn AppDir into AppImage
quick-sharun --make-appimage
