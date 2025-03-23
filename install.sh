#!/bin/bash

echo "Requesting sudo access..."
sudo -v
trap 'kill $(jobs -p) 2>/dev/null' EXIT
while true; do sudo -v; sleep 60; done &

echo "Welcome to the Arch Linux installation script!"

install_package() {
    if ! pacman -Qi $1 &>/dev/null; then
        echo "Installing $1..."
        sudo pacman -S --noconfirm $1 >/dev/null 2>&1 && echo "$1 installed successfully!"
    else
        echo "$1 is already installed. Skipping."
    fi
}

if systemd-detect-virt | grep -q "oracle"; then
    echo "VirtualBox detected! Installing guest utilities..."
    install_package virtualbox-guest-utils
    sudo systemctl enable --now vboxservice
fi

install_package micro
install_package xorg
install_package xorg-server
install_package xorg-xinit
install_package bspwm
install_package sxhkd
install_package alacritty
install_package polybar
install_package zsh

if [ "$SHELL" != "$(which zsh)" ]; then
    echo "Changing shell to Zsh..."
    chsh -s $(which zsh) $USER
fi

if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh... This may take some time. If it hangs, press CTRL+C and rerun the script."
    export RUNZSH=no
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" >/dev/null 2>&1 || {
        echo "Oh My Zsh installation failed! Please check your internet connection and rerun the script."
        exit 1
    }
else
    echo "Oh My Zsh is already installed. Skipping."
fi

CONFIG_DIR="$HOME/arch-setup/home/configs"
if [ -d "$CONFIG_DIR" ]; then
    echo "Copying configuration files..."
    cp -r $CONFIG_DIR/{bspwm,sxhkd,polybar} ~/.config/
    chmod +x ~/.config/bspwm/bspwmrc
else
    echo "Configuration folder not found! Skipping this step."
fi

if [ -f "$HOME/arch-setup/home/.xinitrc" ]; then
    echo "Copying .xinitrc..."
    cp "$HOME/arch-setup/home/.xinitrc" "$HOME/"
else
    echo ".xinitrc file not found! Skipping this step."
fi

echo "Installation complete! Restarting system in 3 seconds..."
sleep 3
reboot
