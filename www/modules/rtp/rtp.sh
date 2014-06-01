#!/bin/sh
HOST=$1
PORT=$2
BITRATE=$3

killall gst-launch-0.10 > /dev/null

gst-launch v4l2src always-copy=false chain-ipipe=true ! capsfilter caps=video/x-raw-yuv,format='(fourcc)'NV12,width=640,height=480,framerate='(fraction)'25 ! queue ! dmaiaccel ! dmaienc_h264 ddrbuf=true encodingpreset=2 ratecontrol=2 intraframeinterval=5 idrinterval=50 targetbitrate=$BITRATE ! rtph264pay ! udpsink port=$PORT host=$HOST enable-last-buffer=false sync=false > /dev/null & 

