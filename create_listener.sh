BASEDIR=$(dirname $0)
source "$BASEDIR/config.sh" 

#| grep -i -P ".*jpe?g" --line-buffered | 

inotifywait -r -e close_write --exclude '(\.sync)' -m --format "%w%f" "$SRC" | while read file; do 
	NEW_FILE=${file/$SRC/$TRG};
	NEW_FOLDER=${NEW_FILE%/*};

	echo "$file"
	if [[ -f $file ]]; then
		if [[ ! -d $NEW_FOLDER ]]; then
			mkdir -p "$NEW_FOLDER"
		fi
		# echo "convert '$file' -resize 1500x1500 -quality 30 '$NEW_FILE'";
		convert "$file" -resize "${IMG_SIZE}x${IMG_SIZE}" -quality 30 "$NEW_FILE";
	fi
done
