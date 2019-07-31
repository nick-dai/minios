#!/bin/bash

rm -rf hd60M.img;
printf "1\n\n\n60\nhd60M.img\n" | bximage;
make
