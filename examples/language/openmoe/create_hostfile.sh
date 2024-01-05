#!/bin/bash

# Input variable
input=$1

# Create a new hostfile
if [ -f hostfile ]; then
  rm hostfile
fi

touch hostfile

# Extract ranges from the input using parameter expansion
ranges="${input##*[}"
ranges="${ranges%]*}"


echo "Range:${ranges}"
# Split the input into prefix and suffix
prefix="${input%%[*}"
suffix="${input##*]}"

echo "prefix:${prefix}, suffix:${suffix}"

# Loop through each range and generate the output
IFS=',' read -ra range_array <<< "$ranges"
for range in "${range_array[@]}"; do
  IFS='-' read -r start end <<< "$range"
  for ((i = start; i <= end; i++)); do
    echo "${prefix}${i}${suffix}" >> hostfile
  done
done

echo "hostfile created!"
