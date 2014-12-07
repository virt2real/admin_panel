#!/bin/sh
HOST=192.168.1.10
PORT=3000
QUALITY=40
FPS=25

killall gst-launch-0.10 > /dev/null

#gst-launch v4l2src always-copy=FALSE chain-ipipe=true ! \
# video/x-raw-yuv,format=\(fourcc\)NV12, width=720, height=576, framerate=\(fraction\)25/1,pitch=736 ! \
# dmaiaccel ! dmaienc_mjpeg qValue=40 ! \
# udpsink port=$PORT host=$HOST sync=false enable-last-buffer=false


gst-launch v4l2src always-copy=FALSE chain-ipipe=true queue-size=1 ! \
video/x-raw-yuv,format=\(fourcc\)NV12, width=640, height=480,framerate=\(fraction\)25/1,pitch=736 ! \
dmaiaccel ! dmaienc_mjpeg qValue=40 ! \
udpsink port=3000 host=192.168.1.10 sync=false enable-last-buffer=false