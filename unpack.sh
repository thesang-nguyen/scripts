#!/bin/bash

# bash script to unpack zip files
# Usage: unpack.sh <zipfile>
# Note that this script will remove the zip file after unpacking

# Check if the user has provided a zip file
if [ $# -eq 0 ]
then
    echo "Usage: unpack.sh <zipfile>"
    exit 1
fi

# Check if the zip file exists
if [ ! -f $1 ]
then
    echo "Error: $1 not found"
    exit 1
fi

# unzip the file to a folder with the same name as the zip file
unzip $1 -d ${1%.zip} 

# remove the zip file
rm $1
