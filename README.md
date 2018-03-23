# media-automation
useful scripts to set up and maintain media automation 

Software:
  Library Management:
    Movies :: CouchPotato
    TV     :: Medusa -shows
    Anime  :: Medusa -anime
    Music  :: ????
    Games  :: ????
  
   Downloading:
    Usenet  :: sabnzbd
    Torrent :: ?????
    
    
Script Explination:

start.sh
	This is the only script the user has to run. 
	Everything else gets called by start.sh. this sets the 
	environment variables and acts as an error handler. 
	also, it helps keep things clean if the user wants to follow along. 

installermenu.sh
	this is the multiple choice installer menu that gets called
	when the first part of start.sh finishes. it lets the
	user select which payload they want to use. 

clean.sh
	this script acts as a placeholder for the installer. 
	it just clears the screen, prints a message, then exits.
	its used in chain loads so that if the user deselects something it will use this instead

wait.sh
	this is another placeholder script. but it works a little differently
	when called it adds a few lines then prompts the user 
	to hit Y to contenue. this lets the user check for any issues that may have happened along the way


