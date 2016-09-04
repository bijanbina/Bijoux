#!/bin/sh
cp ./latexila.scm ~/.gimp-2.8/scripts
for file in ./*.png
do
  echo $file
  gimp -i -b "(change-symbol-color \"$file\")" -b '(gimp-quit 0)'
done

