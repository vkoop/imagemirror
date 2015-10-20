#!/bin/bash

SRC=$1
TRG=$2

#touch jobs
#tail -f jobs | parallel

find "$SRC" -iname "*.jpg" -print0 | while IFS= read -r -d '' file; do
	NEW_FILE=${file/$SRC/$TRG}
	NEW_FOLDER=${NEW_FILE%/*}
	
	if [[ ! -d $NEW_FOLDER ]]; then
		mkdir -p "$NEW_FOLDER"
	fi

	if [[ ! -f $NEW_FILE ]]; then
        	echo "convert '$file' -resize 1500x1500 -quality 30 '$NEW_FILE'; echo 'converted: $file';" >> jobs	
	fi
done

find "$TRG" -iname "*.jpg" -print0 | while IFS= read -r -d '' file; do
	NEW_FILE=${file/$TRG/$SRC}

	if [[ ! -f $NEW_FILE ]]; then
		echo $NEW_FILE
		echo "Remove: $file"
		rm $file
	fi
done

find "$TRG" -type d -empty | xargs rm -Rf
