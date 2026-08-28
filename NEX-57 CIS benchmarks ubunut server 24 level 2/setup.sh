
#!/usr/bin/env bash

# Exit immediately if a command exits with a non-zero status
set -e

# Core Variables
ZIP_URL="https://github.com/ComplianceAsCode/content/releases/download/v0.1.81/scap-security-guide-0.1.81.zip"
ZIP_FILE="scap-security-guide-0.1.81.zip"
EXTRACT_DIR="ssg-content"

echo "=== [1/3] Updating package list and installing dependencies ==="
# Ensure the script runs with privilege for apt installation
sudo apt-get update
sudo apt-get install -y wget unzip

echo "=== [2/3] Downloading SCAP Security Guide v0.1.81 ==="
# Download the zip file if it does not already exist
if [ ! -f "$ZIP_FILE" ]; then
    wget "$ZIP_URL"
else
    echo "$ZIP_FILE already exists, skipping download."
fi

echo "=== [3/3] Extracting content to $EXTRACT_DIR ==="
# Create destination directory and extract
mkdir -p "$EXTRACT_DIR"
unzip -o "$ZIP_FILE" -d "$EXTRACT_DIR"

echo "=== Process completed successfully ==="
