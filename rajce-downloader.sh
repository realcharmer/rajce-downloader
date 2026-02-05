#!/bin/bash

download_album() {
    local ALBUM_URL="$1"
    local FOLDER="$2"

    mkdir -p "$FOLDER"

    echo "Downloading $ALBUM_URL to $FOLDER"

    HTML=$(curl -s "$ALBUM_URL")
    echo "$HTML" \
      | grep -oP '"contentUrl":"\K[^"]+' \
      | sed 's/\\\//\//g' \
      | sort -u \
      | while read -r IMG_URL; do
          FILENAME=$(basename "$IMG_URL")
          echo "Downloading $FILENAME"
          wget -q -O "$FOLDER/$FILENAME" "$IMG_URL"
        done

    echo "Finished downloading to $FOLDER"
    echo
}

if [ "$1" == "-f" ]; then
    FILE="$2"
    if [ ! -f "$FILE" ]; then
        echo "Error: file '$FILE' not found"
        exit 1
    fi

    while read -r URL; do
        [[ -z "$URL" ]] && continue
        FOLDER=$(basename "$URL")
        download_album "$URL" "$FOLDER"
    done < "$FILE"

elif [ -n "$1" ]; then
    ALBUM_URL="$1"
    if [ -n "$2" ]; then
        FOLDER="$2"
    else
        FOLDER=$(basename "$ALBUM_URL")
    fi
    download_album "$ALBUM_URL" "$FOLDER"

else
    echo "Usage:"
    echo "  Single gallery: $0 <gallery_url> [folder_name]"
    echo "  Batch mode:     $0 -f urls.txt"
    exit 1
fi

