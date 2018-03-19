 #!/bin/bash
clear
# set some variables
#USER="medusa"
#DIR="/opt/medusa"
#then to get some input to check them
read -e -p "Please enter a name for the Medusa User: " -i medusa -e  USER
read -e -p "Please enter a directory to store Medusa: " -i /opt/medusa -e DIR

echo " So Medusa is being installed in $DIR as the user $USER"
read -p " sound about rignt? [Y/n]" -n 1 -r
echo    # (optional) move to a new line
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 # handle exits from shell or function but don't exit interactive shell
fi


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

echo "All Set, medusa is up and running on port 8081. Enjoy!"
