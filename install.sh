#!/bin/sh
echo "Please, read this script before executing."
echo "This was made for my own voidlinux, I know what I'm doing, but you should know too."
echo "It's a short script, you won't take more than 20s looking at it."

# Please, remove the following line to confirm you read it:
exit 1

echo "Copying files from config to ~/.config"
cp -irv config/* $HOME/.config

sleep 1

echo "Installing zsh config to your home directory"
cp -irv .zshrc .aliasrc .themerc .zsh_plugins $HOME/

sleep 1
echo "Now copying files from etc to your /etc folder."
echo "sudo will be prompted for obvious reasons."
sudo cp etc/* /etc

echo "Done."
