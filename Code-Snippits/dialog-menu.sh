#!/bin/bash
#not working, not quite sure why. while dialog is pretty i think the 
#regular termianl screen is a better fit




HEIGHT=14
WIDTH=40
CHOICE_HEIGHT=4
BACKTITLE="SAMPLE BACKTITLE"
TITLE="SAMPLE TITLE"
MENU="SELECT AN OPTION"

OPTIONS=(1 "OPTION 1"
	 2 "OPTION 2"
	 3 "OPTION 3"

CHOICE=$(dialog --clear \
		--backtitle "$BACKTITLE" \
		--title "$TITLE" \
		--menu "$MENU" \
		$HEIGHT $WIDTH $CHOICE_HEIGHT \
		"${OPTIONS[@]}"
		2>&1 >/dev/tty)

clear
case $CHOICE in
	1) echo "select option 1";;
	2) echo "select option 2" ;;
	3) echo "select option 3" ;;
esac
