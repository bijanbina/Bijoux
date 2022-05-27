## Awesome

AwesomeWM configuration files

### Dependencies
- qt5-tools: qdbus for youtube support

### Setup Script

```
sudo pacman -S picom papirus-icon-theme rofi qt5-tools awesome openconnect xed polkit-gnome code lxdm parcellite websocat
yay polybar
yay termite
yay spotify
xrandr --output HDMI-3 --output DVI-0 --left-of HDMI-3
```

### Etc Config Files

```
bijan ALL=NOPASSWD: /usr/bin/mount*
bijan ALL=NOPASSWD: /usr/bin/openconnect*
bijan ALL=NOPASSWD: /usr/bin/pkill*
```
