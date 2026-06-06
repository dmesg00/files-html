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

# Show help and init generate index files recursively
if [ -z "${1}" ] ; then
  echo ""
  echo "Usage: $0 <folder>"
  echo ""
else
  cp -rf ${path_gen}/index.sh ${path_gen}/.index.sh 2> /dev/null
  chmod +x ${make_file}
  bash ${path_gen}/index.sh "${1}"
  # Generate index recursive
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
      rm -rf ${find_read}/.res/res 2> /dev/null
      cp -rf ${path_gen}/.res ${find_read}/ 2> /dev/null
      cp -rf ${path_gen}/res ${find_read}/.res 2> /dev/null
      cp -rf ${path_gen}/index.sh ${find_read}/.index.sh 2> /dev/null
      cp -rf ${path_gen}/.index.sh ${find_read}/.index.sh 2> /dev/null
      if [ ! -z "${find_read}" ] ; then
        echo "# Generating index files for ${find_read}"
      fi
      cd ${find_read}
      chmod +x .index.sh 2> /dev/null
      bash .index.sh . 2> /dev/null
      cd ${path_gen}
      countf=$(expr ${countf} + 1)
    done
  else
    echo "# Folder '${1}' not found"
  fi
fi
