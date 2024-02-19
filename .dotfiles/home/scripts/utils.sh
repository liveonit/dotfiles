#!/bin/bash

# Function to escape special characters in a string
escape_special_chars() {
    local escaped_path=""
    local path="$1"

    # Loop through each character in the path
    for ((i = 0; i < ${#path}; i++)); do
        char="${path:i:1}"
        case $char in
            '[' | ']')
                # Escape "[" and "]" characters
                escaped_path+="\\$char"
                ;;
            *)
                escaped_path+="$char"
                ;;
        esac
    done

    echo "$escaped_path"
}
