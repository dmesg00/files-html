#!/bin/bash

##################################################################                                                                                                                                                                         
# files-html - Cool HTML Indexer for Apache/Nginx with Bootstrap #                                                                                                                                                                         
# Date: 16-12-2023                                               #                                                                                                                                                                         
# Author: dmesg00                                                 #                                                                                                                                                                         
# Contact: dmesg00@duck.com                                       #                                                                                                                                                                         
##################################################################

# Variables
find_list="/tmp/find_list"
files_list="/tmp/files_list"
path_gen=$(pwd)
make_file=${path_gen}/index.sh

# Show help and clean index files recursively
if [ -z "${1}" ] ; then
  echo ""
  echo "Usage: $0 <folder>"
  echo ""
else
  # Generate list recursive
  if [ -d "${1}" ] ; then
    list_find=$(find "${1}"/ -type d \( ! -iname ".*" \)) 
    echo > ${find_list}
    for list in $list_find ; do 
      check_list=$(echo $list | grep "/res")
      if [ -z ${check_list} ] ; then 
        echo ${list} >> ${find_list}
      else 
        echo > /dev/null
      fi
    done
    count_find=$(wc -l ${find_list} | cut -d " " -f 1)
    countf=1
    while [ ${countf} -le ${count_find} ] ; do
      find_read=$(cat ${find_list} | head -${countf} | tail -1)
      rm -rf ${find_read}/.res 2> /dev/null
      rm -rf ${find_read}/.index.html 2> /dev/null
      rm -rf ${find_read}/.index.sh 2> /dev/null
      if [ ! -z "${find_read}" ] ; then
        echo "# Cleaning index files for ${find_read}"
      fi
      cd ${find_read}
      cd ${path_gen}
      countf=$(expr ${countf} + 1)
    done
  else
    echo "# Folder '${1}' not found"
  fi
fi
