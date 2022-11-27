#!/usr/bin/env bash

# Script name:	dm-wiki
# Description: Search an offline copy of the arch wiki
# Author: void_femme
# Following DistroTube's arch wiki search script
# https://www.youtube.com/watch?v=fiqKZXQQgpw&t=350&ab_channel=DistroTube
#
# first, download the arch wiki by running
# 	$ sudo pacman -S arch-wiki-docs
#
# find all the files in the /usr/share/doc/arch-wiki/html/en for html files

lang="en"
wikidir="/usr/share/doc/arch-wiki/html/$lang/"
wikidocs="$(find ${wikidir} -iname "*.html")"

main() {
	choice=$(printf '%s\n' "${wikidocs[@]}" | \
		# cut (-d = "using the delimiter '/'") the 8th field onward
		cut -d '/' -f8- | \
		sed -e 's/_/ /g' -e 's/.html//g' | \
		# exclude all files with exactly x characters and no spaces
		grep -vE "^.{32}$" | \
		grep -v ' ' | \
		sort | \
		rofi -dmenu -i -l 20 -p 'Arch Wiki Docs: ') || exit 1

	if [ "$choice" ]; then
		# add the .html and the underscores back into the file names:
		article=$(printf '%s\n' "${wikidir}${choice}.html" | sed 's/ /_/g')
		firefox "$article"
	elif [ "$choice" == "map" ]; then
		echo $1 $2 && exit 0
	else
		echo "Program terminated." && exit 0
	fi
}

main

# next, I want to add functionality that will allow me to add shortcuts to my array of items.
# If I set a specific command, "map" to 
