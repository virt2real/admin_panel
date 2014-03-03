#!/bin/sh

PORT=$1
QUALITY=$2

killall gst-launch-0.10 > /dev/null

gst-launch v4l2src always-copy=false chain-ipipe=true  ! \
	video/x-raw-yuv,format=\(fourcc\)NV12, width=640, height=480, framerate=\(fraction\)20/1 ! \
	dmaiaccel ! dmaienc_mjpeg qValue=$QUALITY copyOutput=true outputBufferSize=0 ! \
	tcpserversink port=$PORT sync=false > /dev/null &