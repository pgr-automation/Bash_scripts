#!/bin/bash

# Check if username, UID, GID, and home directory are provided
if [ $# -lt 4 ]; then
  echo "Usage: $0 <username> <uid> <gid> <home_directory>"
  exit 1
fi

# Assign the variables from script arguments
USER_NAME=$1
USER_UID=$2
USER_GID=$3
USER_HOME=$4

# Check if user already exists
if id "$USER_NAME" &>/dev/null; then
  echo "User '$USER_NAME' already exists."
else
  echo "Creating User: $USER_NAME"

  # Check if the GID exists, if not create a group
  if ! getent group "$USER_GID" &>/dev/null; then
    groupadd -g "$USER_GID" "group_$USER_GID"
  fi

  # Create the user with a custom home directory, specified UID, and GID
  useradd -m -u "$USER_UID" -g "$USER_GID" -d "$USER_HOME" -s /bin/bash "$USER_NAME"

  # Check if user creation was successful
  if [ $? -eq 0 ]; then
    echo "User '$USER_NAME' created successfully with UID $USER_UID, GID $USER_GID, and home directory '$USER_HOME'."
  else
    echo "Failed to create user '$USER_NAME'."
  fi
fi
