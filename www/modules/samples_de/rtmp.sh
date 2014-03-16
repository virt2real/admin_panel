#!/bin/sh
#stop previous gstreamer if launched
killall gst-launch-0.10 > /dev/null

#start streaming
gst-launch v4l2src always-copy=false chain-ipipe=true  ! \
    video/x-raw-yuv,format='(fourcc)'NV12, width=640, height=480, framerate='(fraction)'20/1 ! \
    dmaiaccel ! \
    dmaienc_h264 ddrbuf=true encodingpreset=2 ratecontrol=4 targetbitrate=600000 ! \
    flvmux streamable=false ! \
    rtmpsink location=\"rtmp://localhost/live/ playpath=v2r live=1\" sync=false > /dev/null &
