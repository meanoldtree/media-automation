#!/bin/bash

echo
echo
echo
echo
echo
echo "Have a look at the log so far for any errors that may have popped up"
echo
echo
read -p "Do you want to keep going? [Y/n]" -n 1 -r
if [[ ! $REPLY =~ ^[Yy]$ ]]
then
    [[ "$0" = "$BASH_SOURCE" ]] && exit 1 || return 1 
fi

