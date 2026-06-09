#!/bin/bash

# Get GITHUB_USER from the first script argument ($1), defaulting to 'johnsynnott'
GITHUB_USER="${1:-johnsynnott}"

echo "Fetching public keys for GitHub user: $GITHUB_USER"

# Ensure the ~/.ssh directory and authorized_keys file exist with the rightpermissions so it doesn't complain
mkdir -p "$HOME/.ssh" && chmod 700 "$HOME/.ssh"
touch "$HOME/.ssh/authorized_keys" && chmod 600 "$HOME/.ssh/authorized_keys"

# Define the GitHub keys URL, github publishes all of the users ssh keys to this url.
KEY_URL="https://github.com/${GITHUB_USER}.keys"

# Add a newline to the file first, just in case the existing file doesn't end with one. Certainly not something I would *ever* do by mistake
[ -s "$HOME/.ssh/authorized_keys" ] && echo "" >> "$HOME/.ssh/authorized_keys"

# Attempt download using curl, fallback to wget, fallback to complaining
if command -v curl >/dev/null 2>&1; then
    echo "Downloading keys via curl..."
    curl -fsSL "$KEY_URL" >> "$HOME/.ssh/authorized_keys"
elif command -v wget >/dev/null 2>&1; then
    echo "Downloading keys via wget..."
    wget -qO- "$KEY_URL" >> "$HOME/.ssh/authorized_keys"
else
    echo "Error: Neither curl nor wget is installed. Cannot fetch keys." >&2
    exit 1
fi

echo "Successfully added keys for $GITHUB_USER to $HOME/.ssh/authorized_keys"
