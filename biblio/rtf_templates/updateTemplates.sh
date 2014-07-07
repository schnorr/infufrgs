#!/bin/sh

LIST=templates.list
SOURCE="www.inf.ufrgs.br/biblio/normas/"

while read line
do
	TARGET=${SOURCE}${line}
	rm -f $line
	echo Fetching: $TARGET
	wget $TARGET
	if [ $? -ne 0 ]
	then
		echo Error found, giving up.
		exit 1
	fi
done < $LIST
