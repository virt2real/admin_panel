#!/bin/sh
HOST=$1
PORT=$2
QUALITY=$3
FPS=$4

killall gst-launch-0.10 > /dev/null

gst-launch v4l2src always-copy=FALSE chain-ipipe=true ! \
 video/x-raw-yuv,format=\(fourcc\)NV12, width=640, height=480, framerate=\(fraction\)$FPS/1 ! \
 dmaiaccel ! queue ! dmaienc_mjpeg qValue=$QUALITY ! \
 udpsink port=$PORT host=$HOST sync=false enable-last-buffer=false > /dev/null &
