#!/bin/bash

echo "Добро пожаловать в установочный скрипт Arch Linux!"

echo "Устанавливаем micro..."
sudo pacman -S --noconfirm micro

read -p "Вы запускаете систему в VirtualBox? (yes/no): " vbox
if [[ "$vbox" == "yes" ]]; then
    echo "Устанавливаем VirtualBox Guest Utils..."
    sudo pacman -S --noconfirm virtualbox-guest-utils
    sudo systemctl enable vboxservice
    sudo systemctl start vboxservice
fi

echo "Устанавливаем Xorg..."
sudo pacman -S --noconfirm xorg xorg-server xorg-xinit

echo "Устанавливаем bspwm..."
sudo pacman -S --noconfirm bspwm

echo "Устанавливаем sxhkd..."
sudo pacman -S --noconfirm sxhkd

echo "Устанавливаем терминал Alacritty..."
sudo pacman -S --noconfirm alacritty

echo "Устанавливаем Polybar..."
sudo pacman -S --noconfirm polybar

echo "Устанавливаем Zsh и Oh My Zsh..."
sudo pacman -S --noconfirm zsh
chsh -s /usr/bin/zsh
echo "Скачиваем и устанавливаем Oh My Zsh..."
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

echo "Перемещаем конфигурационные файлы..."
CONFIG_DIR=~/arch-setup/home/configs
if [ -d "$CONFIG_DIR" ]; then
    cp -r $CONFIG_DIR/{bspwm,sxhkd,polybar} ~/.config/
    chmod +x ~/.config/bspwm/bspwmrc
else
    echo "Папка с конфигурациями не найдена! Пропускаем этот шаг."
fi

echo "Перемещаем .xinitrc..."
if [ -f ~/arch-setup/home/.xinitrc ]; then
    cp ~/arch-setup/home/.xinitrc ~/
else
    echo "Файл .xinitrc не найден! Пропускаем этот шаг."
fi

echo "Устанавливаем yay..."
cd ~
git clone https://aur.archlinux.org/yay.git
cd yay
makepkg -si --noconfirm
cd ~

echo "Устанавливаем paru..."
git clone https://aur.archlinux.org/paru.git
cd paru
makepkg -si --noconfirm
cd ~

echo "Установка завершена! Перезагрузка..."
sleep 3
reboot
