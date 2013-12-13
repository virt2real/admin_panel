#!/bin/sh
TMPDIR=/tmpadmin
OUTPUTDIRPARAM=$1

if [ ! "$OUTPUTDIRPARAM" == ""] ; then
	OUTPUTDIR=$OUTPUTDIRPARAM
else
	OUTPUTDIR=/var/www
fi

if [ $2 == 1 ] ; then
	TYPE=
else
	TYPE=-u
fi

mkdir /tmp$TMPDIR

wget --no-cache --output-document=/tmp$TMPDIR/download.zip --no-check-certificate  https://codeload.github.com/virt2real/admin_panel/zip/master
if [ ! $? == 0 ] ; then
	exit 1
fi

unzip -o -q /tmp$TMPDIR/download.zip -d /tmp$TMPDIR
if [ ! $? == 0 ] ; then
	exit 1
fi

if [ $2 == 1 ] ; then
	rm -r $OUTPUTDIR
fi
mv  $TYPE --force /tmp$TMPDIR/admin_panel-master/www/ $OUTPUTDIR/

if [ ! $? == 0 ] ; then
	exit 1
fi

rm -r /tmp$TMPDIR
if [ ! $? == 0 ] ; then
	exit 1
fi

exit 42