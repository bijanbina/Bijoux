#!/bin/sh
make
if [ $? = 0 ]
then
	./CVTest
else
	echo "you got an error"
fi
