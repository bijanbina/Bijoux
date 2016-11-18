#/bin/bash
gsettings set org.gnome.Evince allow-links-change-zoom false # make evince not change zoom
gsettings set org.gnome.Evince.default sidebar-page links # set index as deafult sidebar
echo -n "Install Nautilus scripts [y/n]: "
read answer
if [ $answer == 'y' ]; then
	cp ../Script/bedit ~/.local/share/nautilus/scripts
	cp ../Script/Terminal ~/.local/share/nautilus/scripts
	cp ../Tweaks/scripts-accels ~/.config/nautilus/scripts-accels
	nautilus -q
fi
echo -n "Write sudoers file [y/n]: "
read answer
if [ $answer == 'y' ]; then
	cat ../Tweaks/sudoers >> /etc/sudoers
fi
echo -n "Install packages [y/n]: "
read answer
if [ $answer == 'y' ]; then
	pacman -S qt5-base git qt5-declerative gedit-plugins
fi
echo -n "Install Scripts [y/n]: "
read answer
if [ $answer == 'y' ]; then
	cp ./brep /usr/bin
	cp ./pfind /usr/bin
fi
echo -n "Install Laptop Power Saving Mode [y/n]: "
read answer
if [ $answer == 'y' ]; then
	pacman -S tlp
	cp ../Tweaks/tlp /etc/dafault/
fi
