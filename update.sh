#!/bin/sh

echo "This script updates the dotfiles from *YOUR CURRENT FILES*"
echo "Meaning it will grab your current configs (as long as they match what's originally in the dotfiles)"
echo "and copy them to this folder."
echo "Please, go read the script, always read the script."

# ↓ Remove this line to confirm you read the script.
exit 1

cp -urv $HOME/.zshrc $HOME/.themerc $HOME/.aliasrc $HOME/.zsh_plugins .

cp -urv $HOME/.config/hypr \
        $HOME/.config/kitty \
        $HOME/.config/micro \
        $HOME/.config/mpv \
        $HOME/.config/spicetify \
        $HOME/.config/waybar \
        $HOME/.config/wofi \
        config

cp -urv /etc/rc.local etc
