#!/bin/bash

if [[ "$1" == "" ]]; then
	echo -e "Usage: $0 n[ormal]|e[vil]\n\tn - normal kernel (with code sign)\n\te - evil kernl (without code sign)"
	exit 1
fi

echo "Rebuld the image..."
rm -rf ./hd60M.img*
printf "1\n\n\n60\nhd60M.img\n" | bximage > /dev/null

if [[ ! -d ./build/ ]]; then
	mkdir build
fi

if [[ "$1" == "n" ]]; then
	make
elif [[ "$1" == "e" ]]; then
	make evil
fi
