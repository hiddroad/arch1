#!/bin/bash
rm -rf ~/.config/xfce4/*
mkdir ~/downloads
cd ~/downloads

echo 'Установка AUR (yay)'
sudo pacman -Syu
sudo pacman -S wget --noconfirm
wget git.io/yay-install.sh && sh yay-install.sh --noconfirm

echo 'Создаем нужные директории'
sudo pacman -S xdg-user-dirs --noconfirm
xdg-user-dirs-update

echo 'Установка программ'
sudo pacman -S firefox --noconfirm

echo 'Установить рекомендумые программы?'
read -p "1 - Да, 0 - Нет: " prog_set
if [[ $prog_set == 1 ]]; then
  sudo pacman -S obs-studio sublime-text-dev pamac-aur --noconfirm 
elif [[ $prog_set == 0 ]]; then
  echo 'Установка программ пропущена.'
fi

echo 'Скачать и установить конфиг и темы для XFCE?'
read -p "1 - Да, 0 - Нет: " xfce_set
if [[ $xfce_set == 1 ]]; then

elif [[ $xfce_set == 0 ]]; then
  echo 'Установка конфигов XFCE пропущена.'
fi 
  
echo 'Скачать и установить конфиг и темы для Openbox?'
read -p "1 - Да, 0 - Нет: " openbox_set
if [[ $openbox_set == 1 ]]; then
  echo 'Качаем и устанавливаем настройки Openbox'
  #wget git.io/openbox.tar.gz
  #sudo tar -xzf openbox.tar.gz -C ~/
  #wget git.io/tint2.tar.gz
  #sudo tar -xzf tint2.tar.gz -C ~/
  wget https://github.com/ordanax/arch2018/raw/master/attach/config.tar.gz
  sudo tar -xzf config.tar.gz -C ~/
  yay -S obconf obmenu-generator obkey-git lxappearance-obconf tint2 nitrogen thunar mousepad wmctrl compton papirus-icon-theme
  sudo pacman -S capitaine-cursors
elif [[ $openbox_set == 0 ]]; then
  echo 'Установка конфигов Openbox пропущена.'
fi  

echo 'Убираем меню граб для выбора системы?'
read -p "1 - Да, 0 - Нет: " grub_set
if [[ $grub_set == 1 ]]; then
  wget git.io/grub.tar.gz
  sudo tar -xzf grub.tar.gz -C ~/
  sudo grub-mkconfig -o /boot/grub/grub.cfg
elif [[ $grub_set == 0 ]]; then
  echo 'Пропускаем.'
fi

echo 'Установить conky?'
read -p "1 - Да, 0 - Нет: " conky_set
if [[ $conky_set == 1 ]]; then
  sudo pacman -S conky conky-manager --noconfirm
  wget git.io/conky.tar.gz
  tar -xzf conky.tar.gz -C ~/
elif [[ $conky_set == 0 ]]; then
  echo 'Установка conky пропущена.'
fi

echo 'Включаем сетевой экран'
sudo ufw enable

echo 'Добавляем в автозагрузку:'
sudo systemctl enable ufw

sudo rm -rf ~/downloads
sudo rm -rf ~/arch3.sh

echo 'Установка завершена!'
