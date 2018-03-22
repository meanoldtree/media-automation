#!/bin/bash
# Bash Menu Script Example

TES=""

PS3='Please enter your choice: '
options=("Option 1" "Option 2" "Option 3" "Quit")
select opt in "${options[@]}"
do
    case $opt in
        "Option 1")
            echo "you chose choice 1"
            echo "Variable TES is $TES"
            ;;
        "Option 2")
            echo "you chose choice 2"
            echo "Clearing Value for TES"
           TES=""
            ;;
        "Option 3")
            echo "you chose choice 3"
            echo "Setting TES to the word test"
	    TES="test"
            ;;
        "Quit")
            break
            ;;
        *) echo invalid option;;
    esac
done
