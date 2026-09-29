#!/bin/bash

SOURCE_DIR="$1"
BACKUP_DIR="backups"

if [ -z "$SOURCE_DIR" ]; then
    echo "Usage: $0 <directory>"
    exit 1
fi

if [ ! -d "$SOURCE_DIR" ]; then
    echo "Error: Directory '$SOURCE_DIR' does not exist."
    exit 1
fi

TIMESTAMP=$(date '+%Y-%m-%d_%H-%M-%S')
DIR_NAME=$(basename "$SOURCE_DIR")
BACKUP_FILE="${BACKUP_DIR}/${DIR_NAME}_${TIMESTAMP}.tar.gz"

tar -czf "$BACKUP_FILE" "$SOURCE_DIR"

if [ -f "$BACKUP_FILE" ]; then
    echo "Backup created successfully:"
    echo "$BACKUP_FILE"
    exit 0
else
    echo "Error: Backup creation failed."
    exit 1
fi


