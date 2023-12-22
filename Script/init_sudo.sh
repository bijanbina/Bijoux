#! /bin/bash
echo -n "Write sudoers file [y/n]: "
read answer
if [[ "$answer" == "y" ]]; then
	cat ../Tweaks/sudoers >> /etc/sudoers
fi

echo -n "Install packages [y/n]: "
read answer
if [[ "$answer" == "y" ]]; then
	pacman -S qt5-base git qt5-declerative gedit-plugins
fi

echo -n "Install Scripts [y/n]: "
read answer
if [[ "$answer" == "y" ]]; then
	cp ./brep /usr/bin
	cp ./pfind /usr/bin
fi

echo -n "Install Laptop Power Saving Mode [y/n]: "
read answer
if [[ "$answer" == "y" ]]; then
	pacman -S tlp
	cp ../Tweaks/tlp /etc/dafault/
fi

echo -n "Install udev rules [y/n]: "
read answer
if [[ "$answer" == "y" ]]; then
	touch /etc/udev/rules.d/99-uinput.rules
	echo 'KERNEL=="uinput", GROUP="root", MODE:="7777"' > /etc/udev/rules.d/99-uinput.rules
fi

