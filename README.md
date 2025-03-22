# Arch Setup

Этот репозиторий содержит установочный скрипт для Arch Linux.

## Функции скрипта:

- Устанавливает базовые компоненты (Xorg, bspwm, sxhkd, alacritty, polybar).
- Настраивает виртуальную среду, если система работает в VirtualBox.
- Устанавливает и настраивает Zsh с Oh My Zsh.
- Перемещает пользовательские конфигурации (`bspwm`, `sxhkd`, `polybar`) в `~/.config/`.
- Устанавливает AUR-хелперы `yay` и `paru` для удобной установки пакетов.

## Установка:

```bash
git clone https://github.com/Lyr3c/arch-setup.git
cd arch-setup
chmod +x install.sh
./install.sh
