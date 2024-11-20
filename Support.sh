#!/bin/bash

echo
echo "This script is used to support the main Script, and will provide guidance along the way."
echo
echo "Please wait for the main Script to prompt about configuring OpenSSH"
echo
echo

#OpenSSH Configuration
read -p "Are you configuring OpenSSH?" -n 1 -r
echo    # (optional) move to a new line
if [[  $REPLY =~ ^[Yy]$ ]]
then
    echo "Please uncomment the lines and set the following configurations:"
    echo
    echo "Set 'PermitRootLogin' to no"
    echo "Set 'LoginGraceTime' to 60"
    echo "Set 'LogLevel' to VERBOSE"
    echo "Set 'PermitEmptyPasswords' to no"
    echo "Set 'PasswordAuthentication' to yes"
    echo "Set 'X11Forwarding' to no"
    echo
    echo "Configuration completed!"
fi

#Password Complexity
echo
echo
read -p "Are you configuring password complexity?" -n 1 -r
echo    # (optional) move to a new line
if [[  $REPLY =~ ^[Yy]$ ]]
then
    echo "Please make the following changes to the file:"
    echo
    echo "With the line including 'pam_unix.so' add the following to the end: sha512 remember=5 minlen=8"
    echo
    sleep 20
    echo "A new file will open, you need to uncomment the lines and make the following changes:"
    echo
    echo "Set 'difok' to 3"
    echo "Set 'minlen' to 8"
    echo "Set 'dcredit', 'ucredit', 'lcredit', and 'ocredit' to -1"
    echo "Set 'minclass' to 4"
    echo "Set 'dictcheck' to 1"
    echo "Set 'enforcing' to 1"
    echo "Set 'retry' to 3"
    echo
    echo "Configuration completed!"
fi