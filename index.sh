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

# Commands
ls_command="/bin/ls"

# Show help and init generate index files
if [ -z "${1}" ] ; then
  echo ""
  echo "Usage: $0 <folder>"
  echo ""
else
  # Generate main index folder
  if [ -d "${1}" ] ; then
    #echo "# Generating index files for ${1}"
    ${ls_command} -1 --group-directories-first "${1}"/ > ${files_list}
    rm -rf ${1}/.res/res 2> /dev/null
    cp -rf ${path_gen}/res ${1}/.res 2> /dev/null
    cp -rf ${path_gen}/res/head.html ${1}/.index.html 2> /dev/null
    cp -rf ${path_gen}/.res ${1}/ 2> /dev/null
    cp -rf ${path_gen}/.res/head.html ${1}/.index.html 2> /dev/null
    count_list=$(wc -l ${files_list} | cut -d " " -f 1)
    count=1
    while [ ${count} -le ${count_list} ] ; do
      line_read=$(cat ${files_list} | head -${count} | tail -1)
      if [ "${line_read}" == "index.sh" ] ; then
        count=$(expr ${count} + 1)
      elif [ "${line_read}" == "index-recursive.sh" ] ; then
        count=$(expr ${count} + 1)
      elif [ "${line_read}" == "index.html" ] ; then
        count=$(expr ${count} + 1)
      elif [ "${line_read}" == "res" ] ; then
        count=$(expr ${count} + 1)
      else
        if [ -d "${line_read}" ] ; then
          echo "# Generating entry for '${line_read}'"
          echo -n '<li class="list-group-item"><center><img src=".res/folder.png" width="21" height="21"> <a href="' >> ${1}/.index.html
          echo -n "${line_read}/.index.html" >> ${1}/.index.html
          echo -n '">' >> ${1}/.index.html
          echo -n "${line_read}" >> ${1}/.index.html
          echo '</a></center></li>' >> ${1}/.index.html
          count=$(expr ${count} + 1)
        elif [ -f "${line_read}" ] ; then
          echo "# Generating entry for '${line_read}'"
          echo -n '<li class="list-group-item"><center><img src=".res/file.png" width="21" height="21"> <a href="' >> ${1}/.index.html
          echo -n "${line_read}" >> ${1}/.index.html
          echo -n '">' >> ${1}/.index.html
          echo -n "${line_read}" >> ${1}/.index.html
          echo '</a></center></li>' >> ${1}/.index.html
          count=$(expr ${count} + 1)
        else
          echo "# Generating entry for '${line_read}'"
          echo -n '<li class="list-group-item"><center><img src=".res/link.png" width="23" height="21"> <a href="' >> ${1}/.index.html
          echo -n "${line_read}/.index.html" >> ${1}/.index.html
          echo -n '">' >> ${1}/.index.html
          echo -n "${line_read}" >> ${1}/.index.html
          echo '</a></center></li>' >> ${1}/.index.html
          count=$(expr ${count} + 1)
        fi
      fi
    done
    cat ${path_gen}/res/tail.html >> ${1}/.index.html 2> /dev/null
    cat ${path_gen}/.res/tail.html >> ${1}/.index.html 2> /dev/null
    rm -rf ${files_list}
  else
    echo "# Folder '${1}' not found"
  fi
fi
