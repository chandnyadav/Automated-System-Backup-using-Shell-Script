#!/bin/bash

# Define variables
SOURCE_DIR="/path/to/source"
BACKUP_DIR="/path/to/backup"
S3_BUCKET="s3://your-bucket-name"

# Get current date and time
DATE=$(date +"%Y-%m-%d_%H-%M-%S")

# Create backup directory if it doesn't exist
mkdir -p $BACKUP_DIR

# Create a compressed archive of the source directory
tar -czf $BACKUP_DIR/backup_$DATE.tar.gz -C $SOURCE_DIR .

# Sync backup to AWS S3
aws s3 cp $BACKUP_DIR/backup_$DATE.tar.gz $S3_BUCKET

# Open the crontab file
crontab -e

# Add the following line to schedule the backup script to run daily at 2 AM
0 2 * * * /path/to/backup_script.sh

rsync -av --delete $SOURCE_DIR $BACKUP_DIR/latest/

tar -czf $BACKUP_DIR/backup_$DATE.tar.gz -C $SOURCE_DIR .

aws s3 cp $BACKUP_DIR/backup_$DATE.tar.gz $S3_BUCKET
