#!/bin/bash

# List of files that should be excluded from install
INSTALL_EXCLUDE=("installSync.sh" "netSyncTest.sh" "ns_clone.sh" "ns_pushLocal.sh")
# Files that .sh extension shouldn't be removed
# Warning: These files shouldn't contain source command
SH_EXCLUDE=("ns_variables.sh" "ns_functions.sh") 

#sudo mkdir -m 777 /usr/share/netsync/
# sudo cp ./netSync.service /usr/lib/systemd/system/

# printf "Enable Net Sync services?[y/N]: "
# read response
# if [ "$response" = "y" ]; then
# 	sudo systemctl enable netSync.service
# 	sudo systemctl start netSync.service
# fi

if [ ! -d "/usr/share/netSync" ]; then
	sudo mkdir -p "/usr/share/netSync"
fi

if [ -f "/usr/share/netSync/file_list" ]; then
	sudo rm "/usr/share/netSync/file_list"
fi

sudo touch "/usr/share/netSync/file_list"
sudo chmod 777 "/usr/share/netSync/file_list"

# Icon for net sync notification
sudo cp ./icon.png /usr/share/netSync/icon.png

for file in *; do

    # if file is not inside in INSTALL_EXCLUDE
	if [[ ! " ${INSTALL_EXCLUDE[@]} " =~ " ${file} " ]]; then
		EXTENSION="${file#*.}"
		if [ "$EXTENSION" == "sh" ]; then
			# if file should not have .sh extension
			if [[ ! " ${SH_EXCLUDE[@]} " =~ " ${file} " ]]; then
				sudo cp "$file" "/usr/bin/${file%.*}"
				sudo sed -i 's/\.\/ns_functions.sh/\/usr\/bin\/ns_functions.sh/' "/usr/bin/${file%.*}"
				sudo sed -i 's/python3 \.\/ns_footprints.py/python3 \/usr\/bin\/ns_footprints.py/' "/usr/bin/${file%.*}"
				sudo sed -i 's/python3 \.\/ns_conflict.py/python3 \/usr\/bin\/ns_conflict.py/' "/usr/bin/${file%.*}"
				sudo chmod +x "/usr/bin/${file%.*}"
				echo "/usr/bin/${file%.*}" >> "/usr/share/netSync/file_list"
			else
				sudo cp "$file" "/usr/bin/"
				sudo chmod +x "/usr/bin/$file"
				echo "/usr/bin/$file" >> "/usr/share/netSync/file_list"
			fi
		elif [ "$EXTENSION" == "py" ]; then
			sudo cp "$file" "/usr/bin/"
			sudo chmod +x "/usr/bin/$file"
			echo "/usr/bin/$file" >> "/usr/share/netSync/file_list"
		fi
	fi

done

source ns_functions.sh
ns_version