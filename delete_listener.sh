BASEDIR=$(dirname $0)
source "$BASEDIR/config.sh"

inotifywait -r -e delete -m --format "%w%f" "$SRC" | while read file; do 
	NEW_FILE=${file/$SRC/$TRG}
	echo "trying delete: $NEW_FILE"
	if [[ -f $NEW_FILE ]]; then
		rm "$NEW_FILE"
	fi

	if [[ -d $NEW_FILE ]]; then
		rm -Rf "$NEW_FILE"
	fi
done
