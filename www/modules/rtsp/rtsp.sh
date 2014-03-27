#!/bin/sh
BITRATE=$1

killall gst-launch-0.10 > /dev/null 2>&1
killall test-launch > /dev/null 2>&1

# first version
nice -n -10 test-launch "( v4l2src queue-size=2 always-copy=false chain-ipipe=true ! video/x-raw-yuv,width=640,height=480 ! dmaiaccel ! dmaienc_h264 ddrbuf=true copyOutput=false outputBufferSize=9000000 targetbitrate=$BITRATE ! rtph264pay pt=96 name=pay0 )" > /dev/null &

# second version
# nice -n -10 gst-launch v4l2src queue-size=2 always-copy=false chain-ipipe=true ! video/x-raw-yuv,format='(fourcc)'NV12, width=640, height=480, framerate='(fraction)'30/1 ! dmaiaccel ! dmaienc_h264 ddrbuf=true copyOutput=false outputBufferSize=9000000 targetbitrate=$BITRATE ! rtspsink mapping="/test" service=8554 > /dev/null &
