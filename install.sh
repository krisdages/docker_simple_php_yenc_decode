#!/bin/sh

#sudo apt-get install libboost-regex-dev g++ -y

g++ `php-config --includes` -fpic -c source/yenc_decode_wrap.cpp

if [ ! -e yenc_decode_wrap.o ]; then
	echo "Error creating yenc_decode_wrap.o!"
	exit 1
fi

g++ -fpic -c source/yenc_decode.cpp -lboost_regex

if [ ! -e yenc_decode.o ]; then
	echo "Error creating yenc_decode.o!"
	exit 2
fi

EXTENSIONS=`php-config --extension-dir`

if [ ! -e ${EXTENSIONS} ]; then
	echo "Error locating extensions directory ${EXTENSIONS}!"
	exit 3
fi

g++ -shared *.o -o ${EXTENSIONS}/simple_php_yenc_decode.so -lboost_regex

rm yenc_decode.o
rm yenc_decode_wrap.o

if [ ! -e ${EXTENSIONS}/simple_php_yenc_decode.so ]; then
	echo "Error creating ${EXTENSIONS}/simple_php_yenc_decode.so!"
	exit 4
else
	echo "The extension was compiled successfully."
fi

docker-php-ext-enable simple_php_yenc_decode

#echo "Everything was successful, you should now be able to use the extension in PHP."
