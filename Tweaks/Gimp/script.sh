#!/bin/sh
for file in ./*.png
do
  echo $file
  gimp -i -b '(change-cmap-monocolor "$file")' -b '(gimp-quit 0)'
done

