
# Project: Automated System Backup using Shell Script

**Objective:**
To create an automated backup system using shell scripting that ensures regular and consistent backups of critical data, leveraging various tools to optimize the process and ensure data security.

**Tech Stack:** Shell Script, Cron Jobs, rsync, tar, AWS S3

**Steps and Detailed Explanation:**

1. **Shell Script Development:**
   - **Objective:** Automate the backup process.
   - **Description:** A shell script was written to automate the backup process. The script performs tasks such as identifying the files to be backed up, compressing them, and transferring them to a remote storage solution.

   ```bash
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
   ```

2. **Utilizing Cron Jobs:**
   - **Objective:** Schedule automated backups.
   - **Description:** Cron jobs were set up to run the shell script at regular intervals. This ensures backups are taken without manual intervention.

   ```bash
   # Open the crontab file
   crontab -e

   # Add the following line to schedule the backup script to run daily at 2 AM
   0 2 * * * /path/to/backup_script.sh
   ```

   **Log Example:**

   ```
   Cron Job Scheduled: 2024-07-17 02:00 AM
   Shell Script Execution: /path/to/backup_script.sh
   ```

3. **Using `rsync` for File Synchronization:**
   - **Objective:** Efficiently synchronize files.
   - **Description:** The `rsync` tool was used within the shell script to synchronize files, ensuring only changed files are transferred, which reduces backup time.

   ```bash
   rsync -av --delete $SOURCE_DIR $BACKUP_DIR/latest/
   ```

   **Log Example:**

   ```
   Rsync Execution: 2024-07-17 02:01 AM
   Source Directory: /path/to/source
   Backup Directory: /path/to/backup/latest/
   Files Transferred: 25
   ```

4. **Leveraging `tar` for Compression:**
   - **Objective:** Compress backup data.
   - **Description:** The `tar` command was used to compress the backup data, optimizing storage usage while maintaining data integrity.

   ```bash
   tar -czf $BACKUP_DIR/backup_$DATE.tar.gz -C $SOURCE_DIR .
   ```

   **Log Example:**

   ```
   Tar Execution: 2024-07-17 02:02 AM
   Source Directory: /path/to/source
   Compressed File: /path/to/backup/backup_2024-07-17_02-02-00.tar.gz
   ```

5. **Integration with AWS S3:**
   - **Objective:** Store backups remotely.
   - **Description:** The AWS CLI was used to upload the compressed backup files to an S3 bucket, ensuring a secure and scalable remote storage solution.

   ```bash
   aws s3 cp $BACKUP_DIR/backup_$DATE.tar.gz $S3_BUCKET
   ```

   **Log Example:**

   ```
   AWS S3 Upload: 2024-07-17 02:03 AM
   Compressed File: /path/to/backup/backup_2024-07-17_02-02-00.tar.gz
   S3 Bucket: s3://your-bucket-name
   Upload Status: Success
   ```

**Summary:**
The project successfully created an automated system backup process using shell scripting. By utilizing cron jobs for scheduling, `rsync` for efficient synchronization, `tar` for compression, and AWS S3 for remote storage, the system ensures regular, consistent, and secure backups of critical data. The logs provide detailed insights into each step of the backup process, ensuring transparency and traceability.
