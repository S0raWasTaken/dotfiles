#!/bin/bash

CONFIG="$HOME/.config"
PLUGINS="$HOME/zsh-plugins"

# .config dotfiles
cp -r $CONFIG/alacritty/* config/alacritty
cp -r $CONFIG/bspwm/* config/bspwm
cp -r $CONFIG/flashfocus/* config/flashfocus
cp -r $CONFIG/picom/* config/picom
cp -r $CONFIG/ranger/* config/ranger
cp -r $CONFIG/BetterDiscord/themes/* config/BetterDiscord/themes
cp -r $CONFIG/dunst/* config/dunst
cp -r $CONFIG/kitty/* config/kitty
cp -r $CONFIG/polybar/* config/polybar
cp -r $CONFIG/sxhkd/* config/sxhkd
cp -r $CONFIG/PCSX2/bios/* config/PCSX2/bios

# Home dotfiles
cp -r $HOME/.zshrc .
cp -r $HOME/.aliasrc .
cp -r $HOME/.spacemacs .
cp -r $HOME/.themerc .

# zsh-plugins
cp $PLUGINS/* zsh-plugins

# /etc conf files
cp /etc/paru.conf etc/
cp /etc/pacman.conf etc/
cp /etc/rc.local etc/
cp /etc/makepkg.conf etc/
cp /etc/proxychains.conf etc/
