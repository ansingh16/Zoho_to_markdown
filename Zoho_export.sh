#!/bin/bash

# Script for converting Zoho html export to Markdown

# get all html files
for file in *.html; do
  #get name of the zoho notebook
  Notebook_name=$(grep -o -P '(?<=name&quot).*?(?=;created_date)' $file |  grep -o -P '(?<=quot;).*?(?=&quot)' | head -1)
  # get title of bookmark 
  title=$(grep -o -P '(?<=name&quot).*?(?=;created_date)' $file |  grep -o -P '(?<=quot;).*?(?=&quot)' | tail -2 | awk -F"," '{print $1}')
  # get url
  url=$(grep -o -P '(?<=href=").*?(?=">link)' $file)
  
  # if the notebook already exists append the data to
  # markdown file with notebook name else create one. 
  if [ ! -f "$Notebook_name.md" ]
  then
      touch "$Notebook_name.md"
  else
      echo "[$title]($url)  " >> "$Notebook_name.md"
      echo "" >> "$Notebook_name.md"
  fi

  echo $Notebook_name
  echo $url
  echo $title
  echo " "
done
