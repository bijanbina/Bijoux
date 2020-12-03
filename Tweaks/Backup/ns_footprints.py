#!/bin/python3
# Name: Net Sync Conflict
# Handle files in servers with difference modification date
# from host and copy files in confilicts folder
# Input: 
#		1. Path local backup
#		2. Number Of Server
#		3. Reference file for read all files in servers and host
#		4. Directory name for copy conflict files
#		5. Difference mode(enable[1], disable[0])
#		6. Run script as service(enable[1], disable[0])
# example: python3 ns_conflict.py <path-local> <server-count> <reference-list> <dir-name-conflict> <diff-mode> <service-enable>


import os, sys, time, subprocess, shlex, re
from time import strftime
from datetime import datetime

# return modification time 'filename' in
# timestamp(second) format
# if file not found return -1.
# If the file date is in the future,
# date the file change with current time.
def get_modification_time(filename):
	curr_time = time.time()
	try:
		date_file = os.path.getmtime(filename)
	except FileNotFoundError:
		date_file = -1

	# modification time is in the future.
	if curr_time < date_file: 
		if DIFF_MODE == 1: # difference mode enable
			if SERVICE_ENABLE == 0: # service mode disable
				log_msg = 'future: host ---> ' + filename
				print(log_msg)
		else:
			command_str = "touch -a -m " + filename
			os.system(command_str)
		date_file = curr_time

	return date_file

# Copy files in path_files to destination path
# if modification date changed or add new file 
# 'type_file' : 1 ---> footprint, 2 ---> pin
def copy_files(path_files, destination_path, type_file):
	
	for path in path_files:
		split_path = path.split('/')
		if len(split_path) < 2:
			continue

		last_folder = split_path[-2] # Folder file
		file = split_path[-1] # file
		base_name = ''
		if '.' in file: # check file have extension
			base_name = file.split('.')[0]
			if type_file == 2: # pin
				check_name = re.match(re.compile( "^" + last_folder + "_[a-z]"), base_name)
				if check_name is None: # format pin name is incorrect
					if SERVICE_ENABLE == 1: # service mode enable
						date = datetime.now().strftime("%m/%d/%Y %H:%M")
						log_msg = date + ', <ns_footprints>: The format of the Pinname is incorrect' + '[' + path + ']'
						print(log_msg, file = log_err)
					else:
						log_msg = 'The format of the Pinname is incorrect [' + path + ']'
						print(log_msg)
					continue
				else:
					base_name = base_name.split('_')[0]
					
		if base_name.lower() == last_folder.lower(): # check folder and file name is equal

			host_date = get_modification_time(path)
			template_date = get_modification_time(destination_path + file)

			if host_date > template_date: # file is changed
				if DIFF_MODE == 1: # difference mode enable
					if SERVICE_ENABLE == 0: # service mode disable
						log_msg = 'change: host ---> ' + path
						print(log_msg)
				else:
					src = path
					des = destination_path
					command_str = "cp -up " + src + " " + des 
					os.system(command_str)
					date = datetime.now().strftime("%m/%d/%Y %H:%M")
					log_msg = date + ', Update: ' + '[' + path + ']'
					print(log_msg, file = log_fp)


if __name__ == '__main__':

	if len(sys.argv) < 4:
		print('Input arguments not enough.')
		sys.exit(1)

	LOCAL_STORAGE = sys.argv[1]
	PROJECT_NAME = sys.argv[2]
	DIFF_MODE = int(sys.argv[3])
	SERVICE_ENABLE = int(sys.argv[4])

	FOOTPRINT_PATH = LOCAL_STORAGE + "/host/SVN/" + PROJECT_NAME + "/Footprints"
	log_fp  = open(LOCAL_STORAGE + "/log_footprint", "a")
	log_err = open(LOCAL_STORAGE + "/log_error", "a")

	TEMPLATE_PATH = LOCAL_STORAGE + "/host/SVN/Template/"
	TEMPLATE_FP_PATH  = TEMPLATE_PATH + "Footprints/"
	TEMPLATE_PINS_PATH  = TEMPLATE_PATH + "Pins/"
	os.system('mkdir -p ' + TEMPLATE_PINS_PATH)
	os.system('mkdir -p ' + TEMPLATE_FP_PATH)

	# Copy footprint files
	cmd = "find " + FOOTPRINT_PATH + " -maxdepth 2 -type f ( -iname \"*.dra\" -o -iname \"*.psm\" )"
	proc = subprocess.Popen(shlex.split(cmd), stdout=subprocess.PIPE, stderr=subprocess.PIPE)
	stdout, stderr = proc.communicate()
	path_footprints = stdout.decode('ascii').split('\n') #Split path with newline
	path_footprints = list(filter(None, path_footprints)) #Remove empty element
	copy_files(path_footprints, TEMPLATE_FP_PATH, type_file=1)

	# Copy pin files
	cmd = "find " + FOOTPRINT_PATH + " -maxdepth 2 -type f -iname \"*.pad\""
	proc = subprocess.Popen(shlex.split(cmd), stdout=subprocess.PIPE, stderr=subprocess.PIPE)
	stdout, stderr = proc.communicate()
	path_pins = stdout.decode('ascii').split('\n') #Split path with newline
	path_pins = list(filter(None, path_pins)) #Remove empty element
	copy_files(path_pins, TEMPLATE_PINS_PATH, type_file=2)

	log_fp.close()
	log_err.close()
