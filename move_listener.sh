BASEDIR=$(dirname $0)
source "$BASEDIR/config.sh" 

#| grep -i -P ".*jpe?g" --line-buffered | 

inotifywait -r -e moved_to --exclude '(\.sync)' -m --format "%w%f" "$SRC" | while read file; do 
	NEW_FILE=${file/$SRC/$TRG};
	NEW_FOLDER=${NEW_FILE%/*};

	if [[ -d $file ]]; then
		mkdir -p "$NEW_FILE"
		for f in $(find "$file" -iname '*.jpg' -o -iname '*.jpeg'); do
			NEW_F=${f/$SRC/$TRG};
			convert "$f" -resize 1500x1500 -quality 30 "$NEW_F";
		done
	fi

	if [[ -f $file ]]; then
		if [[ ! -d $NEW_FOLDER ]]; then
			mkdir -p "$NEW_FOLDER"
		fi
		echo "convert '$file' -resize 1500x1500 -quality 30 '$NEW_FILE'";
		convert "$file" -resize 1500x1500 -quality 30 "$NEW_FILE";
	fi
done
