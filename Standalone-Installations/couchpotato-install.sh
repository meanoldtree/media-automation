# Simple automation script to install couchpotato

#Grab some shell Variables

clear

read -e -p "Please enter a name for the Medusa User: " -i couchpotato -e  USER
read -e -p "Please enter a directory to store CouchPotato: " -i /opt/couchpotato -e DIR
echo
echo
echo
echo " So CouchPotato  is being installed in $DIR and it runs as $USER?"
read -p " sound about rignt? [Y/n]" -n 1 -r
echo    
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 
fi

# handle exits from shell or function but don't exit interactive shell, neat little code snippit.




# lets install some dependencies first
sudo apt-get update
# LXML for website scraping
sudo apt-get install python3-lxml python-pip
# and a pip install for pyOpenSSL
pip install --upgrade pyopenssl

#now we add the system user
sudo addgroup --system $USER
sudo adduser --disabled-password --system --home $DIR --gecos "CouchPotato" --ingroup $USER $USER

#create the installation directory
sudo mkdir $DIR
#chown it
sudo chown $USER:$USER $DIR
#clone couchpotato into the directory
sudo -u $USER git clone https://github.com/CouchPotato/CouchPotatoServer.git $DIR

# Set up Autostart
#this is for a systemd installation, need to add upstart and SysV


#Change some values in the init script
sudo -u $USER sed -i -e "s/couchpotato/$USER/g" $DIR/init/couchpotato.service
sudo -u $USER sed -i -e "s,/var/lib/CouchPotatoServer,$DIR,g" $DIR/init/couchpotato.service

#copy the init confg
sudo cp $DIR/init/couchpotato.service /etc/systemd/system/couchpotato.service
#chown it to make sure
sudo chown root:root /etc/systemd/system/couchpotato.service
sudo chmod 644 /etc/systemd/system/couchpotato.service
#and enable it
sudo systemctl enable couchpotato



# ~~~ Config section
# all of the variables need to be written into /etc/default/couchpotato
CONF=/etc/default/couchpotato
#add the variables to a local file in the working directory, not elegent but it works
echo "CP_USER=$USER" >> couchpotato
echo "CP_HOME=$DIR" >> couchpotato
echo "CP_DATA=$DIR/db" >> couchpotato

#delete the existing defaults file if it exists
sudo rm $CONF
sudo cp couchpotato $CONF
sudo rm couchpotato
sudo chown root:root $CONF
sudo chmod 644 $CONF

# note from CPs Github
# Accepted variables with default values -if any- in parentheses:
# CP_USER	# username to run couchpotato under (couchpotato)
# CP_HOME	# directory of CouchPotato.py (/opt/couchpotato)
# CP_DATA	# directory of couchpotato's db, cache and logs (/var/opt/couchpotato)
# CP_PIDFILE	# full path of couchpotato.pid (/var/run/couchpotato/couchpotato.pid)
# PYTHON_BIN	# full path of the python binary (/usr/bin/python)
# CP_OPTS	# extra cli options for couchpotato, see 'CouchPotato.py --help'
# SSD_OPTS	# extra options for start-stop-daemon, see 'man start-stop-daemon'

#now that that is set, lets fire up the service 

sudo systemctl start couchpotato

echo "All Set, CouchPotato is up and running on port 5050. Enjoy!"
#and thats it. simple little script but it makes deploying things like this a lot less time consuming.
