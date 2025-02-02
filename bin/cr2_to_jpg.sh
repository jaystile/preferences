#!/bin/bash
# Utility to quickly render raw Canon files to jpg
for pic in *.CR2
do
	darktable-cli "$pic" "$(basename ${pic%.CR2}.jpg)";
done
