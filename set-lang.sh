#!/bin/bash

##################################################################
# files-html - Cool HTML Indexer for Apache/Nginx with Bootstrap #
# Date: 16-12-2023                                               #
# Author: dmesg00                                                 #
# Contact: dmesg00@duck.com                                       #
##################################################################

dir=$(dirname $0)
lang_dir="$(dirname $0)/lang"

# List available languages
lang_available=$(ls -1 ${lang_dir}/ 2> /dev/null | cut -d "." -f 1)

# Set language
if [ -z "${1}" ] ; then
  echo ""
  echo "* Set language for html indexer"
  echo ""
  echo "Sintax: $0 <lang>"
  echo ""
  echo "Available lang:" ${lang_available}
  echo ""
else
  if [ -f "${lang_dir}/${1}.html" ] ; then
    cp -rf "${lang_dir}/${1}.html" "${dir}/res/head.html"
    echo "Language '${1}' set correctly"
    echo "Run 'make-html-browser.sh' for to generate the html files"
    exit 0
  else
    echo "Language '${1}' not available"
    exit 1
  fi
fi

