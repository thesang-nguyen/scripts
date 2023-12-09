#!/bin/bash

# bash script to unpack each zip files in a directory to a folder with the same name as the zip file
# Usage: unpack_all.sh <directory>
# Note that this script will remove the zip files after unpacking

# Check if the user has provided a directory
if [ $# -eq 0 ]
then
    echo "Usage: unpack_all.sh <directory>"
    exit 1
fi

# Check if the directory exists
if [ ! -d $1 ]
then
    echo "Error: $1 not found"
    exit 1
fi

# unzip each file in the directory
for file in $1/*.zip
do
    unzip $file -d ${file%.zip}  # unzip the file to a folder with the same name as the zip file
    rm $file  # remove the zip file
done
