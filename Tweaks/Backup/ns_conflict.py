#!/bin/python3
# Name: Net Sync Create Modification Date
# Handle files in servers with difference modification date
# from host and copy files in confilicts folder
# Input: 
#		1. Path local backup
#		2. Number Of Server
#		3. Reference file for read all files in servers and host
#		4. Directory name for copy conflict files
#		5. Log file name
# example: python ns_create_md 2 /mnt/hdd2/Backup/reference_list 200520


import os
import sys
import time
from time import strftime
from datetime import datetime


if __name__ == '__main__':

	if len(sys.argv) < 5:
		print('Input arguments not enough.')
		sys.exit(1)

	PATH_LOCAL = sys.argv[1]
	NUMBER_OF_SERVERS = int(sys.argv[2])
	REFERENCE_FILE = sys.argv[3]
	DIR_NAME_CONFLICT = sys.argv[4]
	LOG_CONF_FILE = PATH_LOCAL + "/log_conflict"

	log_conflict = open(LOG_CONF_FILE, "a")
	error_f = open(PATH_LOCAL + "/log_error", "a")
	ref_files = open(REFERENCE_FILE, 'r') 
	Lines = ref_files.read().splitlines()
	curr_time = time.time() # Return the time in seconds since the epoch as a floating point number.
	for filename in Lines:

		path_file = PATH_LOCAL + "/host/" + filename
		try:
			host_date_file = os.path.getmtime(path_file)
			if curr_time < host_date_file: # file modification time is in the future.  
				command_str = "touch -a -m " + path_file
				os.system(command_str)
				host_date_file = curr_time
		except FileNotFoundError:
			host_date_file = -1

		date_files = []
		for i in range(NUMBER_OF_SERVERS):
			path_file = PATH_LOCAL + "/server" + str(i+1) + "/" + filename
			try:
				df = os.path.getmtime(path_file) # date_file
				if curr_time < df: # file modification time is in the future. 
					print(df, host_date_file)
					command_str = "touch -a -m " + path_file
					os.system(command_str)
					date_files.append(curr_time)
				else:
					date_files.append(df)
				# date_files.append(os.path.getmtime(path_file))
			except FileNotFoundError:
				date_files.append(-1)

		date_arg_sorted = [] #sorted date argument from max to min
		[date_arg_sorted.append(i[0]) for i in sorted(enumerate(date_files), key=lambda x:x[1], reverse = True)]

		#The file does not exist inside any server
		if date_files[date_arg_sorted[0]] == -1: 
			continue

		file_dir = os.path.relpath(os.path.join(filename, os.pardir))

		for i,server_id in enumerate(date_arg_sorted):
			if host_date_file < date_files[server_id]:
				if i > 0:
					if date_files[date_arg_sorted[i]] == date_files[date_arg_sorted[i-1]]: # stop in case of rest of files are the same
						break
					else: # in case of conflict copy files to the conflict folder
						src = PATH_LOCAL + "/server" + str(server_id+1) + "/" + filename
						des = DIR_NAME_CONFLICT + "/server" + str(server_id+1) + "/" + file_dir
						command_str = "mkdir -p " + des
						os.system(command_str)
						command_str = "cp -rup " + src + " " + des 
						os.system(command_str)
						date = datetime.now().strftime("%m/%d/%Y %H:%M")
						log_msg = date + ' <conflict.py>: server' + str(server_id+1) + ' -> conflict ' + '[' + filename + ']' 
						print(log_msg, file = log_conflict)	
			elif host_date_file > date_files[server_id]: 
				date = datetime.now().strftime("%m/%d/%Y %H:%M")
				log_msg = date + ' <conflict.py>: host date file > server' + str(server_id+1) + ' date file ' + '[' + filename + ']' 
				print(log_msg, file = error_f)
				log_conflict.close()
				error_f.close()
				ref_files.close()
				sys.exit(1)

	log_conflict.close()
	error_f.close()
	ref_files.close()