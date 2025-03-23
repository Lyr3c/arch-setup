#!/bin/bash

echo "Welcome to the Arch Linux installation script!"

echo "Installing micro..."
sudo pacman -S --noconfirm micro >/dev/null 2>&1

read -p "Are you running this system in VirtualBox? (yes/no): " vbox
if [[ "$vbox" == "yes" ]]; then
    echo "Installing VirtualBox Guest Utils..."
    sudo pacman -S --noconfirm virtualbox-guest-utils >/dev/null 2>&1
    sudo systemctl enable vboxservice
    sudo systemctl start vboxservice
fi

echo "Installing Xorg..."
sudo pacman -S --noconfirm xorg xorg-server xorg-xinit >/dev/null 2>&1

echo "Installing bspwm..."
sudo pacman -S --noconfirm bspwm >/dev/null 2>&1

echo "Installing sxhkd..."
sudo pacman -S --noconfirm sxhkd >/dev/null 2>&1

echo "Installing Alacritty terminal..."
sudo pacman -S --noconfirm alacritty >/dev/null 2>&1

echo "Installing Polybar..."
sudo pacman -S --noconfirm polybar >/dev/null 2>&1

echo "Installing Zsh..."
sudo pacman -S --noconfirm zsh >/dev/null 2>&1
chsh -s /usr/bin/zsh

echo "Downloading and installing Oh My Zsh..."
export RUNZSH=no
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" >/dev/null 2>&1

echo "Moving configuration files..."
CONFIG_DIR=~/arch-setup/home/configs
if [ -d "$CONFIG_DIR" ]; then
    cp -r $CONFIG_DIR/{bspwm,sxhkd,polybar} ~/.config/
    chmod +x ~/.config/bspwm/bspwmrc
else
    echo "Configuration folder not found! Skipping this step."
fi

echo "Moving .xinitrc..."
if [ -f ~/arch-setup/home/.xinitrc ]; then
    cp ~/arch-setup/home/.xinitrc ~/
else
    echo ".xinitrc file not found! Skipping this step."
fi

echo "Installing yay..."
sudo pacman -S --noconfirm yay >/dev/null 2>&1

echo "Installing paru..."
git clone https://aur.archlinux.org/paru.git ~/paru
cd ~/paru
makepkg -si --noconfirm >/dev/null 2>&1
cd ~

echo "Installation complete! Restarting system..."
sleep 3
reboot
