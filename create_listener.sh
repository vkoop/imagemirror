BASEDIR=$(dirname $0)
source "$BASEDIR/config.sh"

inotifywait -r -e close_write -m --format "%w%f" "$SRC" | while read file; do 
	NEW_FILE=${file/$SRC/$TRG}
	echo "convert '$file' -resize 1500x1500 -quality 30 '$NEW_FILE'";
	convert "$file" -resize 1500x1500 -quality 30 "$NEW_FILE";
done
