This project ensures apache server is set up on the ubuntu server and if not, it does the required installation for the same followed by apache server logs upload to s3 bucket as a tar file.
automation.sh file is used as the executable.

#Make the script executible
chmod  +x  /root/Automation_Project/automation.sh
#switch to root user with sudo su
sudo  su
./root/Automation_Project/automation.sh

# or run with sudo privileges
sudo ./root/Automation_Project/automation.sh
