#!/bin/bash -e

# Takes a target file as an argument
# strips it from empty lines and comments
# saves the file with ".bp. + current date and time" prefix 
# overwrites the original file


file=$(echo "$1" | awk -F/ '{print $NF}')

# creates a path to cd into - the awk command gets rid of the file name
path=$(realpath "$1" | awk -F'/' 'sub(FS $NF,x)')
file_bp=$file.bp.$(date +%F-%H:%M)
tmp_file=$file.$(date +%H%M%S)

cd "$path" || true
cp -p "$file" "$file_bp"

grep -v '^[[:space:]]*$' "$file" > "$tmp_file"
grep -v '#' "$tmp_file" > "$file"
rm "$tmp_file"

echo -e "\nNew file $file: \n"
cat $file
