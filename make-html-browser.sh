#!/bin/bash

##################################################################
# files-html - Cool HTML Indexer for Apache/Nginx with Bootstrap #
# Date: 16-12-2023                                               #
# Author: dmesg00                                                 #
# Contact: dmesg00@duck.com                                       #
##################################################################

dir=$(dirname $0)
dir_files="$(dirname $0)/files"

# Create index for HTML
cd ${dir}
bash clean.sh ${dir_files}
bash index-recursive.sh ${dir_files}
