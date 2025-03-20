#!/bin/bash
# This script downloads all Debian packages and their dependecies required for offline installation

# Check for the package list file
PKG_FILE="pkg_list.txt"
if [ ! -f "$PKG_FILE" ]; then
    echo "Package list file not found. Exiting..."
    exit 1
fi

# Set the download directory
TARGET_DIR="./offline_deps"
mkdir -p $TARGET_DIR

# Load the package list
echo "Loading package list..."
PACKAGE_LIST=($(grep -Ev '^\s*#|^\s*$' "$PKG_FILE"))

if [ ${#PACKAGE_LIST[@]} -eq 0 ]; then
    echo "No packages found in the package list. Exiting..."
    exit 1
fi

echo "Packages to be downloaded:"
printf '%s\n' "${PACKAGE_LIST[@]}"

# Check dependencies for each package
echo "Checking dependencies..."
ALL_DEPS=""
for pkg in "${PACKAGE_LIST[@]}"; do
    deps=$(apt-rdepends "$pkg" 2>/dev/null | grep -Eo '^[[:space:]]*[a-z0-9+.-]+' | sed 's/^[[:space:]]*//')
    ALL_DEPS+="$deps"$'\n'
done

# Remove duplicates and count the number of dependencies
ALL_DEPS=$(echo "$ALL_DEPS" | sort -u)
NUM_DEPS=$(echo "$ALL_DEPS" | wc -l)
echo "Number of unique dependencies: $NUM_DEPS"

# Download the packages
echo "Starting download..."
cd "$TARGET_DIR" || { echo "Failed to change directory. Exiting..."; exit 1; }
for pkg in $ALL_DEPS; do
    echo "Downloading: $pkg"
    apt download "$pkg"
done

echo "Download complete."