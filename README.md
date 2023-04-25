# Unicorn
The official Unicorn Desktop environment

# Installation

**Dependencies:**

```
sudo apt install xfwm4 tint2 rofi feh
```

**Compile:**

```
git clone https://github.com/rhino-linux/unicorn
cd unicorn
mv .xinitrc ~/
mv .config/* ~/.config
sudo mv icons/* /usr/share/icons
sudo mv backgrounds/* /usr/share/backgrounds
```

Reboot into tty and then type `startx`
