#!/bin/bash

PROGRAM_LIST_FILE=$1
# Read the list of programs line by line
while IFS= read -r program; do
    if [ -n "$program" ]; then
        echo "Do you wish to delete the program: $program? (y/n)"
        read -r response
        if [[ "$response" =~ ^[Yy]$ ]]; then
            sudo apt purge "$program*"
            if [ $? -eq 0 ]; then
                echo "$program has been successfully removed."
            else
                echo "Failed to remove $program."
            fi
        else
            echo "Skipping $program."
        fi
    fi
done < "$PROGRAM_LIST_FILE"

echo "Script execution complete."