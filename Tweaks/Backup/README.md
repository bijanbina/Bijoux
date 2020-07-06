# Backup

Syncronize n-server files with each other, save conflicts and make logs from deleted or modified files.

## How to Install

### Step 1

Rename `setup_variables.template` to `setup_variables.sh` and set following variables:
- SERVER_COUNT : Number of Server for syncronize
- PATH_LOCAL : Path to backup temp folder
- IP_SERVER[1-9] : Ip servers
- SERVER[1-9]_USER : Username and password for servers
- BACKUP_PERIOD : Minimal time between each backup proccess [Hour]
- CHECK_TIMEOUT : Time between each checking sync cycle [Minute]
- MOUNT_SLEEP : Time between failed mounting servers [Minute]
- TEMP_FOLDER : Path to save temp files for backup

### Step 2

run `installSync.sh`

