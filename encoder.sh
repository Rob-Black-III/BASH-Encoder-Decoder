#!/bin/bash

# author: Rob Black rdb5063@rit.edu


# Arg Checking
[ -z "$1" ] && echo "No Input File" && exit 1
[ -z "$2" ] && echo "No Secret Key File" && exit 1

if [[ -f "$3" ]]; then
	rm $3
	touch $3
else
	touch $3
fi

# Declare Variables to Filenames
IN=$1
SECRET=$2
OUT=$3

# Load key, values into arrays
KEYS=()
VALUES=()

echo "+-------------+"
echo "|   Encoder   |"
echo "+-------------+"

echo ""
echo "Reading Secret Key File"
echo "------------------"


shopt -s extglob
while IFS=, read k v;do
	v="${v##*( )}"

	echo "'$k' will be changed to '$v'"
	KEYS+=($k)
	VALUES+=($v)
done < "$SECRET"
shopt -u extglob

echo ""
echo "Reading Input File and Encoding to Output File"
echo "------------------"

# Print Key and Value Arrays
# echo "${KEYS[*]}"
# echo "${VALUES[*]}"

while read line; do
	for word in $line; do
		echo "Read in '$word'"
		flag=false
		for i in "${!KEYS[@]}"; do
			if [ "$word" = "${KEYS[$i]}" ]; then
				echo -n ${VALUES[$i]} >> $OUT
				echo -n " " >> $OUT
				flag=true
				break;
			fi
		done

		if ! $flag; then
			echo -n $word >> $OUT
			echo -n " " >> $OUT
		fi
	done

	# Remove the space added if we are at the end of a line
	# Works without it but with a trailing space at end of each line (for diff)
	truncate -s-1 $OUT

	echo "" >> $OUT
done < $IN

echo ""
echo "Done. Check outfile."

# while IFS= read -ra line;
