#!/bin/bash

# Usage: ./direnv-init-python.sh /path/to/destination

set -e

# Function to print error messages and exit
error_exit() {
    echo "Error: $1" >&2
    exit 1
}

# 1. Accepts directory_path or defaults to current directory
DEST_DIR="${1:-.}"

# Check if directory exists
if [ ! -d "$DEST_DIR" ]; then
    error_exit "Destination directory does not exist: $DEST_DIR"
fi

# 2. Determines location that the script is running in
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# 3. Get handle to local template file
TEMPLATE_FILE="$SCRIPT_DIR/envrc-python-template"

if [ ! -f "$TEMPLATE_FILE" ]; then
    error_exit "Template file not found in script directory: $TEMPLATE_FILE"
fi

# 4. Copy template file to input parameter destination
cp -v "$TEMPLATE_FILE" "$DEST_DIR/.envrc" || error_exit "Failed to copy template file."

