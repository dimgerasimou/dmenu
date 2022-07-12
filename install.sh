#!/bin/sh

if [[ -s installlog.txt ]]; then
	rm installlog.txt
fi

if [[ "$1" == "--delete-config" ]]; then
	rm build/config.h
fi

sudo make --directory=build clean install 1> /dev/null 2> installlog.txt

if [[ -s installlog.txt ]]; then
	echo "Installation finished with errors. Check installlog.txt to find what's wong."
else
	echo "Installation finished with no errors."
	rm installlog.txt
fi
