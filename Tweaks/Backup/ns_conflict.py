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
from time import gmtime, strftime


if __name__ == '__main__':

	if len(sys.argv) < 6:
		print('Input arguments not enough.')
		sys.exit(1)

	PATH_LOCAL = sys.argv[1]
	NUMBER_OF_SERVERS = int(sys.argv[2])
	REFERENCE_FILE = sys.argv[3]
	DIR_NAME = sys.argv[4]
	LOG_FILE = sys.argv[5]

	log_f = open(LOG_FILE, "a")
	error_f = open(PATH_LOCAL + "/log_error", "a")
	ref_files = open(REFERENCE_FILE, 'r') 
	Lines = ref_files.read().splitlines()
	for line in Lines:

		path = PATH_LOCAL + "/host/" + line
		try:
			host_date_file = os.path.getmtime(path)
		except FileNotFoundError:
			host_date_file = -1

		date_files = []
		for i in range(NUMBER_OF_SERVERS):
			path = PATH_LOCAL + "/server" + str(i+1) + "/" + line
			try:
				date_files.append(os.path.getmtime(path))
			except FileNotFoundError:
				date_files.append(-1)
				break

		date_arg_sorted = []
		[date_arg_sorted.append(i[0]) for i in sorted(enumerate(date_files), key=lambda x:x[1], reverse = True)]

		file_dir = os.path.relpath(os.path.join(line, os.pardir))
		for index,i in enumerate(date_arg_sorted):
			if host_date_file < date_files[i]:
				if index == 0:
					src = PATH_LOCAL + "/server" + str(i+1) + "/" + line
					des = PATH_LOCAL + "/host/" + file_dir
					script = "mkdir -p " + des
					os.system(script)
					script = "cp -rup " + src + " " + des 
					os.system(script)
					date = strftime("%m/%d/%Y %H:%M", gmtime())
					log_msg = date + ' : server' + str(i+1) + ' -> host ' + '[' + line + ']' 
					print(log_msg, file = log_f)
				elif date_files[index] == date_files[index-1]:
					break
				else:
					src = PATH_LOCAL + "/server" + str(i+1) + "/" + line
					des = DIR_NAME + "/server" + str(i+1) + "/" + file_dir
					script = "mkdir -p " + des
					os.system(script)
					script = "cp -rup " + src + " " + des 
					os.system(script)
					date = strftime("%m/%d/%Y %H:%M", gmtime())
					log_msg = date + ' : server' + str(i+1) + ' -> conflict ' + '[' + line + ']' 
					print(log_msg, file = log_f)
			elif host_date_file > date_files[i]:
				date = strftime("%m/%d/%Y %H:%M", gmtime())
				log_msg = date + ' : host date file > server' + str(i+1) + ' date file ' + '[' + line + ']' 
				print(log_msg, file = error_f)
				break