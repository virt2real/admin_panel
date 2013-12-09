#!/bin/sh
LOCATION=$1
PLAYPATH=$2
BITRATE=$3

killall gst-launch-0.10 > /dev/null

gst-launch v4l2src always-copy=false chain-ipipe=true  ! \
    video/x-raw-yuv,format='(fourcc)'NV12, width=640, height=480, framerate='(fraction)'20/1 ! \
    dmaiaccel ! \
    dmaienc_h264 ddrbuf=true encodingpreset=2 ratecontrol=4 targetbitrate=$BITRATE ! \
    flvmux streamable=true ! \
    rtmpsink location=\"$LOCATION playpath=$PLAYPATH live=1\" sync=false > /dev/null &

