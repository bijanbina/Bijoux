#!/bin/python3
# Name: Net Sync Conflict
# Handle files in servers with difference modification date
# from host and copy files in confilicts folder
# Input: 
#		1. Path local backup
#		2. Number Of Server
#		3. Reference file for read all files in servers and host
#		4. Directory name for copy conflict files
#		5. Log file name
#		6. Difference mode(enable[1], disable[0])
# example: python3 ns_conflict.py <path-local> <server-count> <reference-list> <dir-name-conflict> <diff-mode>


import os
import sys
import time
from time import strftime
from datetime import datetime


if __name__ == '__main__':

	if len(sys.argv) < 6:
		print('Input arguments not enough.')
		sys.exit(1)

	PATH_LOCAL = sys.argv[1]
	NUMBER_OF_SERVERS = int(sys.argv[2])
	REFERENCE_FILE = sys.argv[3]
	DIR_NAME_CONFLICT = sys.argv[4]
	LOG_CONF_FILE = PATH_LOCAL + "/log_conflict"
	DIFF_MODE = int(sys.argv[5])

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
				if DIFF_MODE == 0:
					command_str = "touch -a -m " + path_file
					os.system(command_str)
				else:
					log_msg = 'future: host ---> ' + filename
					print(log_msg)
				host_date_file = curr_time
		except FileNotFoundError:
			host_date_file = -1

		date_files = []
		for i in range(NUMBER_OF_SERVERS):
			path_file = PATH_LOCAL + "/server" + str(i+1) + "/" + filename
			try:
				df = os.path.getmtime(path_file) # date_file
				if curr_time < df: # file modification time is in the future. 
					if DIFF_MODE == 0:
						print(df, host_date_file)
						command_str = "touch -a -m " + path_file
						os.system(command_str)
					else:
						log_msg = 'future: server' + str(server_id+1) + ' ---> ' + filename
						print(log_msg)
					date_files.append(curr_time)
				else:
					date_files.append(df)
			except FileNotFoundError:
				date_files.append(-1)

		date_arg_sorted = [] #sorted date argument from max to min
		[date_arg_sorted.append(i[0]) for i in sorted(enumerate(date_files), key=lambda x:x[1], reverse = True)]

		#The file does not exist inside any server
		if date_files[date_arg_sorted[0]] == -1: 
			continue

		file_dir = os.path.relpath(os.path.join(filename, os.pardir))

		for i,server_id in enumerate(date_arg_sorted):
			if date_files[server_id] == -1:
				continue
			if host_date_file < date_files[server_id]:
				if i == 0: # in case of latest modified file 
					log_msg = 'modified: server' + str(server_id+1) + ' ---> ' +filename
					print(log_msg)
				if i > 0:
					if date_files[date_arg_sorted[i]] == date_files[date_arg_sorted[i-1]]: # stop in case of rest of files are the same
						break
					else: # in case of conflict copy files to the conflict folder
						if DIFF_MODE == 0:
							src = PATH_LOCAL + "/server" + str(server_id+1) + "/" + filename
							des = DIR_NAME_CONFLICT + "/server" + str(server_id+1) + "/" + file_dir
							command_str = "mkdir -p " + des
							os.system(command_str)
							command_str = "cp -rup " + src + " " + des 
							os.system(command_str)
							date = datetime.now().strftime("%m/%d/%Y %H:%M")
							log_msg = date + ' <conflict.py>: server' + str(server_id+1) + ' -> conflict ' + '[' + filename + ']' 
							print(log_msg, file = log_conflict)	
						else:
							log_msg = 'conflict: server' + str(server_id+1) + ' ---> ' + filename
							print(log_msg)

			elif int(host_date_file) > int(date_files[server_id]):
				if DIFF_MODE == 0:
					date = datetime.now().strftime("%m/%d/%Y %H:%M")
					log_msg = date + ' <conflict.py>: host date file > server' + str(server_id+1) + ' date file ' + '[' + filename + ']'
					date_host = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(host_date_file))
					date_server = time.strftime('%Y-%m-%d %H:%M:%S', time.localtime(date_files[server_id]))
					log_msg += '\nhost: ' + str(date_host) + ' (' + str(int(host_date_file)) + ')'
					log_msg += ', server' + str(server_id+1) + ': ' + str(date_server) + ' (' + str(int(date_files[server_id])) + ')'
					print(log_msg, file = error_f)
					log_conflict.close()
					error_f.close()
					ref_files.close()
					sys.exit(1)
				else:
					log_msg = 'host error: server' + str(server_id+1) + ' ---> ' + filename
					print(log_msg)

	log_conflict.close()
	error_f.close()
	ref_files.close()