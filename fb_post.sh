#!/bin/bash

ACCESS_TOKEN=""

PAGE_ID=""

WATCH_DIR="/euer_dir"

if [ ! -d "$WATCH_DIR" ]; then
  echo "Das Verzeichnis $WATCH_DIR existiert nicht!"
  exit 1
fi

while true; do
  FILE=$(inotifywait -e 'create,move' --format "%f" "$WATCH_DIR" 2>/dev/null)
  
  if [ -n "$FILE" ]; then
    FILE_PATH="$WATCH_DIR/$FILE"
    
    if [ -f "$FILE_PATH" ]; then
      MSG=$(cat "$FILE_PATH")

      curl -X POST \
      -F "message=$MSG" \
      -F "access_token=$ACCESS_TOKEN" \
      "https://graph.facebook.com/v21.0/$PAGE_ID/feed" 

      rm "$FILE_PATH"
    else
      echo "Die Datei $FILE_PATH existiert nicht mehr."
    fi
  fi
done
