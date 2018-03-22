 #!/bin/bash
clear
# ~~~ This section Depreciated but left to help understand the process
# set some variables
#USER="medusa"
#DIR="/opt/medusa"
#then to get some input to check them
# ~~~ End Section

#Read into  variables some importand pieces the user needs to be able to change. 
#another thing to add here would be a choice between a DEB/RPM/APK based system install.
# Need to look into seeing if that can be autodetected. 
read -e -p "Please enter a name for the Medusa User: " -i medusa -e  USER
read -e -p "Please enter a directory to store Medusa: " -i /opt/medusa -e DIR

echo " So Medusa is being installed in $DIR as the user $USER"
read -p " sound about rignt? [Y/n]" -n 1 -r
echo    
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 
fi

# handle exits from shell or function but don't exit interactive shell, neat little code snippit.


# install some prerequisits
sudo apt-get update
 sudo apt-get install unrar-free git-core openssl libssl-dev python2.7
# adding a systen user
sudo addgroup --system $USER
sudo adduser --disabled-password --system --home /var/lib/medusa --gecos "Medusa" --ingroup $USER $USER
# next to add the directory where medusa will live
sudo mkdir $DIR 
sudo chown $USER:$USER $DIR
sudo -u $USER git clone https://github.com/pymedusa/Medusa.git $DIR
# emable the system service
sudo cp -v $DIR/runscripts/init.systemd /etc/systemd/system/medusa.service
sudo chown root:root /etc/systemd/system/medusa.service
sudo chmod 644 /etc/systemd/system/medusa.service
# and start it 
sudo systemctl enable medusa
sudo systemctl start medusa
#clean the garbage off the screen
clear
echo "All Set, medusa is up and running on port 8081. Enjoy!"
#and thats it. simple little script but it makes deploying things like this a lot less time consuming.
