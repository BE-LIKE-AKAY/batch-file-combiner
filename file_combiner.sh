#!/bin/bash

# Function to display error messages in red
error() {
    echo -e "\033[1;31mError: $1\033[0m"
    exit 1
}

# Function to display success messages in green
success() {
    echo -e "\033[1;32m$1\033[0m"
}

# Function to prompt the user for input with a default value
prompt_with_default() {
    read -p "$1 [$2]: " response
    echo "${response:-$2}"
}

# Prompt the user for the folder containing the text files
folder_path=$(prompt_with_default "Enter the folder path containing the text files" "$PWD")

# Check if the folder path provided exists and is a directory
if [ ! -d "$folder_path" ]; then
    error "Folder not found or is not a directory."
fi

# Prompt the user for the output file name
output_file=$(prompt_with_default "Enter the output file name" "combined_text.txt")

# Check if the output file already exists
if [ -e "$output_file" ]; then
    read -p "Output file already exists. Do you want to overwrite it? (y/n): " overwrite
    if [ "$overwrite" != "y" ]; then
        error "Operation aborted."
    fi
fi

# Change directory to the specified folder containing text files
cd "$folder_path" || error "Unable to change directory."

# Check if there are any text files in the specified folder
if ! compgen -G "*.txt" > /dev/null; then
    error "No text files found in the specified folder."
fi

# Concatenate all text files into a single file
cat *.txt > "$output_file" || error "Failed to combine text files."

success "Combined text files into $output_file"
