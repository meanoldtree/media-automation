#!/bin/bash
#code snippet that calls the installation menu
#in the actions section, for each item selected it will cat -n "&& ./script.sh" >> selectedscriptinstall.sh
#which is a shell script that simply has the hashbang, and cd /opt/install-scripts && ./users.sh
#this moves it into the install directory and runs the useradd scripts


#Menu options
options[0]="AAA"
options[1]="BBB"
options[2]="CCC"
options[3]="DDD"
options[4]="EEE"

#Actions to take based on selection
function ACTIONS {
    if [[ ${choices[0]} ]]; then
        #Option 1 selected
        echo "Option 1 selected"
    fi
    if [[ ${choices[1]} ]]; then
        #Option 2 selected
        echo "Option 2 selected"
    fi
    if [[ ${choices[2]} ]]; then
        #Option 3 selected
        echo "Option 3 selected"
    fi
    if [[ ${choices[3]} ]]; then
        #Option 4 selected
        echo "Option 4 selected"
    fi
    if [[ ${choices[4]} ]]; then
        #Option 5 selected
        echo "Option 5 selected"
    fi
}

#Variables
ERROR=" "

#Clear screen for menu
clear



#Menu function
function MENU {
#header text goes here?
    echo
    echo
    echo "Header Text"
    echo
    echo
    echo "Menu Options"
    for NUM in ${!options[@]}; do
        echo "[""${choices[NUM]:- }""]" $(( NUM+1 ))") ${options[NUM]}"
    done
    echo "$ERROR"
}

#Menu loop
while MENU && read -e -p "Select the desired options using their number (again to uncheck, ENTER when done): " -n1 SELECTION && [[ -n "$SELECTION" ]]; do
    clear
    if [[ "$SELECTION" == *[[:digit:]]* && $SELECTION -ge 1 && $SELECTION -le ${#options[@]} ]]; then
        (( SELECTION-- ))
        if [[ "${choices[SELECTION]}" == "+" ]]; then
            choices[SELECTION]=""
        else
            choices[SELECTION]="+"
        fi
            ERROR=" "
    else
        ERROR="Invalid option: $SELECTION"
    fi
done

ACTIONS
