#!/bin/sh
#current_d = `pwd`
#cd ../Binary
#if [ $? = 1 ]
#then
#	cd ..
#	mkdir Binary
#	cd Binary
#fi
qmake -o Makefile openCV.pro > /dev/null
make -s
if [ $? = 0 ]
then
	./openCV
else
	echo "you got an error"
fi
