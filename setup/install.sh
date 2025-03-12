#!/bin/bash

# Остановить выполнение при ошибке
set -e

echo "Обновляем систему..."
sudo pacman -Syu --noconfirm

# Проверка и установка недостающих пакетов
packages=("xorg-server" "xorg-xinit" "bspwm" "polybar" "micro")

for pkg in "${packages[@]}"; do
    if pacman -Q $pkg &>/dev/null; then
        echo "$pkg уже установлен."
    else
        echo "Устанавливаем $pkg..."
        sudo pacman -S --noconfirm $pkg
    fi
done

# Проверяем, установились ли пакеты
if pacman -Q "${packages[@]}" &>/dev/null; then
    echo "Все пакеты установлены!"
else
    echo "Ошибка: не удалось установить один или несколько пакетов."
    exit 1
fi

# Создание ~/.xinitrc для запуска BSPWM
echo "exec bspwm" > ~/.xinitrc

if [ -f ~/.xinitrc ]; then
    echo "~/.xinitrc успешно создан!"
else
    echo "Ошибка: ~/.xinitrc не был создан!"
    exit 1
fi

# Копирование конфигов
echo "Копируем конфигурации BSPWM и Polybar..."
mkdir -p ~/.config/bspwm ~/.config/polybar

cp -r ~/setup/configs/bspwm/* ~/.config/bspwm/
cp -r ~/setup/configs/polybar/* ~/.config/polybar/

echo "Удаляем установочный скрипт и папку setup..."
rm -rf ~/setup

echo "Установка завершена! Перезапусти систему и запусти X с помощью startx."
