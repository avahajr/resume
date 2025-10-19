#!/bin/bash

FILENAME="resume.tex"

grep -n '\\resumeItem{' "$FILENAME" | awk -F'\\resumeItem{' '
{
  split($2, arr, "}")
  item=arr[1]
  gsub(/^ +| +$/, "", item)  # Trim spaces
  if (item != "" && substr(item, length(item), 1) != ".")
    print "Line " $1 ": Missing period at end of \\resumeItem -> \"" item "\""
}
'
