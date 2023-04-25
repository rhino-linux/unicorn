# Unicorn
The official Unicorn Desktop environment

# Installation

**Dependencies:**

```
sudo apt install xfwm4 tint2 rofi feh
```

**Compile:**

```
cd ~
git clone https://github.com/rhino-linux/unicorn
cd ~/unicorn
mv .xinitrc ~
cd .config/
mv * ~/.config
cd ..
cd icons/
sudo mv * /usr/share/icons
cd ..
cd backgrounds
sudo mv * /usr/share/backgrounds
```

Reboot into tty and then type `startx`


icons/ -> /usr/share/icons
backgrounds -> /usr/share/backgrounds