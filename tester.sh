#!/bin/bash

# author: Rob Black rdb5063@rit.edu

# Arg Checking
[ -z "$1" ] && echo "No Input File" && exit 1
[ -z "$2" ] && echo "No Secret Key File" && exit 1

if [[ -f "testerEncoded.txt" ]];then
	rm "testerEncoded.txt"
	touch "testerEncoded.txt"
else
	touch "testerEncoded.txt"
fi

if [[ -f "testerDecoded.txt" ]];then
	rm "testerDecoded.txt"
	touch "testerDecoded.txt"
else
	touch "testerDecoded.txt"
fi

IN=$1
SECRET=$2
ENCODED="testerEncoded.txt"
DECODED="testerDecoded.txt"

<< --Comment--

Remove the /dev/null 2>&1 for a more detailed output of each script
--Comment--

echo "+------------+"
echo "|  Encoding  |"
echo "+------------+"
bash ./encoder.sh $IN $SECRET $ENCODED > /dev/null 2>&1

echo "Diff betweeen Input and Encoded"
echo "--------------"
diff -y $IN $ENCODED
echo ""

echo "+------------+"
echo "|  Decoding  |"
echo "+------------+"
bash ./decoder.sh $ENCODED $SECRET $DECODED > /dev/null 2>&1

echo "Diff betweeen Input and Decoded"
echo "--------------"
diff -y $IN $DECODED
echo ""
