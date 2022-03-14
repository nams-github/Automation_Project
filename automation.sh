echo "***************************************package list at the start of the script***********************************"
apt list --installed
echo "***************************************update the packages*********************************************"
sudo apt update -y
echo "***************************************Check on apache2 package installation status******************************"
dpkg --get-selections | grep -w "apache2\s" | grep -w "install" > test2.txt
if [ $(grep "apache2" test2.txt | wc -l ) = 1 ]
then
   echo "apache2 is already installed"
else
   echo "apache2 is not installed"
   sudo apt-get --yes install apache2
fi

rm test2.txt

echo "***********************************Apache2 service status check***************************************************"
if [ $(sudo systemctl status apache2| grep -v grep | grep 'dead' | wc -l) = 0 ]
then
   echo "Process is running."
 else
   echo "**********************************As APACHE2 service is down, starting it****************************************"
   sudo systemctl start apache2
   sudo systemctl status apache2
fi



if [ $(aws --version | grep aws | wc -l) = 1 ]
then
   echo "awscli is installed"
else
   echo "Since awscli is not installed, installing it"
   sudo apt update
   sudo apt-get install awscli
fi

myname=Namita
s3bucket=upgrad-namita
cd /var/log/apache2
timestamp=$(date '+%d%m%Y-%H%M%S')
sudo tar cfz $myname-httpd-logs-$timestamp.tar access.log error.log
ls -lrt | tail -1 | awk '{ print $NF }'
filename=$(ls -lrt | tail -1 | awk '{ print $NF }')
cp $filename /tmp
aws s3 cp /tmp/$filename s3://$s3bucket

str1=$(echo $filename | awk -F- '{print $4F-$NF}')
echo $str1




cd /var/www/html
if [ $(ls | grep inventory.html | wc -l) = 0 ]
then
        echo "inventory.html file is not present. So creating it"
        echo -e "LogType\t\tDateCreated\t\tType\tSize" >> inventory.html
fi

size=$(stat --format %s /tmp/$filename)

echo $size
printf 'httpd-logs\t(%s)\ttar\t%s \n' "$str1" "$size" >> inventory.html



if  [ $(crontab -u root -l | grep "0 10" | wc -l) = 0 ]
then
        echo "no cron job is defined for the user"

        sudo crontab -l > /etc/cron.d/automation
        sudo echo "0 10 * * * sudo /root/Automation_Project/automation.sh" >> /etc/cron.d/automation
        sudo crontab /etc/cron.d/automation
fi

root@ip-172-31-89-93:~#
