#/bin/bash
gsettings set org.gnome.Evince allow-links-change-zoom false # make evince not change zoom
gsettings set org.gnome.Evince.default sidebar-page links # set index as deafult sidebar
cp ../Script/bedit ~/.local/share/nautilus/scripts
cp ../Script/Terminal ~/.local/share/nautilus/scripts
cp ../Tweaks/scripts-accels ~/.config/nautilus/scripts-accels
nautilus -q
