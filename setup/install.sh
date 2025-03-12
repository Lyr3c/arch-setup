#!/bin/bash

# Установка базовых зависимостей
echo "Установка базовых зависимостей..."
sudo pacman -S --noconfirm bspwm polybar git xorg xorg-xinit

# Создание директорий для конфигов
echo "Создание директорий для конфигов..."
mkdir -p ~/.config/bspwm
mkdir -p ~/.config/polybar

# Копирование конфигов из репозитория в нужные директории
echo "Копирование конфигов в систему..."
cp -r ./configs/bspwm/bspwmrc ~/.config/bspwm/
cp -r ./configs/polybar/config ~/.config/polybar/

# Настройка прав доступа к файлам конфигурации
echo "Настройка прав доступа..."
chmod +x ~/.config/bspwm/bspwmrc

# Завершающие сообщения
echo "Установка и настройка завершены."
echo "Не забудьте настроить автозапуск BSPWM и Polybar, а также перезапустите систему."

# Удаление установочного скрипта и конфигов после установки
echo "Удаление установочного скрипта и конфигов..."
rm -rf ~/setup
