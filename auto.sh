#!/bin/bash

echo "Rebuld the image..."
rm -rf ./hd60M.img*
printf "1\n\n\n60\nhd60M.img\n" | bximage > /dev/null

if [[ ! -d ./build/ ]]; then
	mkdir build
fi

make
