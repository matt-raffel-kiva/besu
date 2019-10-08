#!/usr/bin/env bash


NETWORK_ROOT=$HOME/besu_pvn
REMOVE_ALL=0

if [[ "$1" == "rebuild" ]]; then
    REMOVE_ALL=1;
    shift
fi

if [[ "$1" != "" ]]; then
    NETWORK_ROOT=$1
fi

if [[ $REMOVE_ALL == 1 ]]; then
    echo "this removes the entire besu setup!!!!"
    read -p "Do you wish to continue? (y/n)" yn
    case $yn in
        [Yy]* ) echo "rm -rf ${NETWORK_ROOT};"; break;;
        [Nn]* ) exit;;
        * ) exit 1;;
    esac
else
    echo "this resets the besu DBs"
    read -p "Do you wish to continue? (y/n)" yn
    case $yn in
        [Yy]* ) echo "tbd do stuff"; break;;
        [Nn]* ) exit;;
        * ) exit 1;;
    esac

fi



