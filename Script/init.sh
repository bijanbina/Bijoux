#! /bin/bash
gsettings set org.gnome.Evince allow-links-change-zoom false # make evince not change zoom
gsettings set org.gnome.Evince.default sidebar-page links # set index as deafult sidebar

echo -n "Install Nautilus scripts [y/n]: "
read answer
if [[ "$answer" == "y" ]]; then
	cp ../Script/bedit ~/.local/share/nautilus/scripts
	cp ../Script/Terminal ~/.local/share/nautilus/scripts
	cp ../Tweaks/scripts-accels ~/.config/nautilus/scripts-accels
	nautilus -q
fi

sudo ./init_sudo.sh
