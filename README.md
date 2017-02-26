simple_php_yenc_decode
======================

Basic yEnc decoder extension for PHP5 written in c++ using swig, with install script for use with Docker image php:5.

This is a work in progress and is not yet recommended for use.

### Intro:

The intention of this extension is to be used with nZEDb for decoding
partial yEnc articles from usenet, where the yEnc checks are not needed.

If the method fails or if the string is not yEnc, an empty string is returned.

Boost regex is used, because gcc and g++'s regex are not working until 4.9 (currently 4.7/4.8 are the popular versions).

### Requirements:

Boost regex is required for compiling (1.53, 1.54, 1.55 tested).

On ubuntu:

libboost-regex-dev
(depends on libboost-regex and libboost-dev)

### Installation:

Run the following command:

`sh install.sh`

This command compiles simple_php_yenc_decode.so, adds it to the php extension dir which can be found with `php-config --extension-dir`, and enables the extension with `docker-php-ext-enable simple_php_yenc_decode`.

### Example:

The example (test.php) checks if you have the extension loaded, then it tries to decode
the file called yEnc.zip.yEnc which is a zip file encoded with yEnc, the zip contains a wikipedia HTML page,
you can extract the zip and run this HTML page in a browser if you want to see if it is successful.

