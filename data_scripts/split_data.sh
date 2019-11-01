#!/bin/bash

while IFS= read -r line; do
  filename=$line
  trainfilename="${filename}_train"
  valfilename="${filename}_val"
  testfilename="${filename}_test"
  echo $filename
  echo $newfilename
  no_of_lines=$(wc -l $filename|cut -d" " -f1)
  no_of_lines_train=$((no_of_lines*70/100))
  echo $no_of_lines $no_of_lines_train
  split -l $no_of_lines_train -d -a 1 $filename $trainfilename
  mv "${trainfilename}0" $trainfilename
  remaining_lines=$(wc -l ${trainfilename}1|cut -d" " -f1)
  no_of_lines_val=$((remaining_lines*50/100))
  split -l $no_of_lines_val -d -a 1 "${trainfilename}1" $valfilename
  mv "${valfilename}0" $valfilename
  mv "${valfilename}1" $testfilename
  rm ${trainfilename}1
done < "$1"
