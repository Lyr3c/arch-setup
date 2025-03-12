#!/bin/bash

# Обновление системы и установка необходимых пакетов
echo "Обновляем систему и устанавливаем X-сервер, BSPWM и Polybar..."
pacman -Syu --noconfirm
pacman -S --noconfirm xorg-server xorg-xinit bspwm polybar

# Создание ~/.xinitrc для запуска BSPWM
echo "exec bspwm" > ~/.xinitrc

# Проверка создания ~/.xinitrc
if [ -f ~/.xinitrc ]; then
  echo "~/.xinitrc был успешно создан!"
else
  echo "Ошибка: не удалось создать ~/.xinitrc"
fi

# Копирование конфигурации BSPWM из папки setup/configs/bspwm
echo "Копируем конфигурацию BSPWM..."
mkdir -p ~/.config/bspwm
cp ~/setup/configs/bspwm/* ~/.config/bspwm/

# Копирование конфигурации Polybar из папки setup/configs/polybar
echo "Копируем конфигурацию Polybar..."
mkdir -p ~/.config/polybar
cp ~/setup/configs/polybar/* ~/.config/polybar/

# Самоудаление скрипта и папки с установочными файлами
echo "Удаляем установочный скрипт и папки с конфигами..."
rm -rf ~/setup

# Завершаем
echo "Установка завершена."
