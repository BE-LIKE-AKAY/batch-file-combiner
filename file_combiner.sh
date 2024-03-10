#!/bin/bash

# Prompt the user for the folder containing the text files
read -p "Enter the folder path containing the text files: " folder_path

# Prompt the user for the output file name
read -p "Enter the output file name: " output_file

# Change directory to the specified folder containing text files
cd "$folder_path" || { echo "Folder not found."; exit 1; }

# Concatenate all text files into a single file
cat *.txt > "$output_file"

echo "Combined text files into $output_file"
