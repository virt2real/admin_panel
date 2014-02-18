#!/bin/sh
LOCATION=$1
PLAYPATH=$2
LIVE=1
STREAMABLE=true


###################################################
# outputBufferSize: Size of the output buffer
# flags: readable, writable
# Integer. Range: 0 - 2147483647 Default: 0
OUTPUTBUFFERSIZE=0

###################################################
# copyOutput: Boolean that set if the output buffers should be copied into standard gst buffers
# flags: readable, writable
# Boolean. Default: false
COPYOUTPUT=false

###################################################
# ratecontrol: Rate Control Algorithm to use:
#	1 - Constant Bit Rate (CBR), for video conferencing
#	2 - Variable Bit Rate (VBR), for storage
#	3 - Two pass rate control for non real time applications
#	4 - No Rate Control is used
#	5 - User defined on extended parameters
# flags: readable, writable
# Integer. Range: 1 - 5 Default: 2
RATECONTROL=1

###################################################
# encodingpreset: Encoding Preset Algorithm to use:
#	0 - Default (check codec documentation)
#	1 - High Quality
#	2 - High Speed
#	3 - User defined on extended parameters
# flags: readable, writable
# Integer. Range: 0 - 3 Default: 3
ENCODINGPRESET=2

###################################################
# maxbitrate: Maximum bit-rate to be supported in bits per second
# flags: readable, writable
# Integer. Range: 1000 - 20000000 Default: 50000000
MAXBITRATE=$3

###################################################
# targetbitrate: Target bit-rate in bits per second, should be <= than the maxbitrate
# flags: readable, writable
# Integer. Range: 1000 - 20000000 Default: 10000000
TARGETBITRATE=$3

###################################################
# intraframeinterval: Interval between two consecutive intra frames:
#	0 - Only first I frame followed by all P frames
#	1 - No inter frames (all intra frames)
#	2 - Consecutive IP sequence (if no B frames)
#	N - (n-1) P sequences between I frames
# flags: readable, writable
# Integer. Range: 0 - 2147483647 Default: 30
INTRAFRAMEINTERVAL=50

###################################################
# profile: H264 Profile to use:
#	66  - Base Line
#	77  - Main Line
#	100 - High Line (Default)
# flags: readable, writable
# Integer. Range: 0 - 100 Default: 100
PROFILE=100

###################################################
# level: H264 Level to use:
#	9 - For 1.b
#	10 - For 1.0
#	.. Any valid level between
#	51 - For 5.1
# flags: readable, writable
# Integer. Range: 9 - 51 Default: 40
LEVEL=10
#LEVEL=41

###################################################
# entropy: Entropy mode:
#	0 - CAVLC
#	1 - CABAC
# flags: readable, writable
# Integer. Range: 0 - 1 Default: 1
ENTROPY=1

###################################################
# t8x8intra: Enable 8x8 Transform for I Frame (only for High Profile)
# flags: readable, writable
# Boolean. Default: true
T8X8INTRA=false

###################################################
# t8x8inter: Enable 8x8 Transform for P Frame (only for High Profile)
# flags: readable, writable
# Boolean. Default: false
T8X8INTER=false

###################################################
# ddrbuf: Use DDR buffers instead of IMCOP buffers
# flags: readable, writable
# Boolean. Default: false
DDRBUF=true

###################################################
# ntemplayers: Number of temporal Layers for SVC:
#	0   - one layer
#	1   - two layers (F, F/2)
#	2   - three layers (F, F/2, F/4)
#	3   - four layers (F, F/2, F/4, F/8)
#	255 - all P refer to previous I or IDR frame
# flags: readable, writable
# Integer. Range: 0 - 255 Default: 0
NTEMPLAYERS=0

###################################################
# seqscaling: Sequence scaling matrix present:
#	0 = Disable
#	1 = Auto (Default)
#	2 = Low
#	3 = Moderate
#	4 = Reserved
# flags: readable, writable
# Integer. Range: 0 - 4 Default: 1
SEQSCALING=1

###################################################
# qpintra : Quantization Parameter (QP) for I frame (only valid when rate control is disabled or is fixed QP)
# flags: readable, writable
# Integer. Range: 1 - 31 Default: 28
QPINTRA=28

###################################################
# qpinter: Quantization Parameter (QP) for P frame (only valid when rate control is disabled or is fixed QP)
# flags: readable, writable
# Integer. Range: 1 - 31 Default: 28
QPINTER=28

###################################################
# rcalgo: Rate Control Algorithm (requires ratecontrol set to 5):
#	0 - CBR
#	1 - VBR (Default)
#	2 - Fixed QP
#	3 - CVBR
#	4 - Custom RC1 - Fixed size frame
#	5 - Custom CBR1
#	6 - Custom VBR1
# flags: readable, writable
# Integer. Range: 0 - 6 Default: 1
RCALGO=0

###################################################
# airrate: Adaptive intra refresh. This indicates the maximum number of MBs(per frame) that can be refreshed using AIR.
# flags: readable, writable
# Integer. Range: 0 - 2147483647 Default: 0
AIRRATE=0

###################################################
# idrinterval: Interval between two consecutive IDR frames
# flags: readable, writable
# Integer. Range: 0 - 2147483647 Default: 0
IDRINTERVAL=100

###################################################
# bytestream: Generate h264 NAL unit stream instead of 'packetized' stream (no codec_data is generated)
# flags: readable, writable
# Boolean. Default: false
BYTESTREAM=false

###################################################
# aud: Generate h264 Access Unit Delimiters format
# flags: readable, writable
# Boolean. Default: false
AUD=false

###################################################
# headers: Include on the stream the SPS/PPS headers
# flags: readable, writable
# Boolean. Default: false
HEADERS=false

#GST_DEBUG=3,*rtmp*:5  \
gst-launch v4l2src always-copy=false chain-ipipe=true  ! \
    video/x-raw-yuv,format='(fourcc)'NV12, width=640, height=480, framerate='(fraction)'25/1 ! \
    dmaiaccel ! \
    dmaienc_h264 \
	outputBufferSize=$OUTPUTBUFFERSIZE \
	copyOutput=$COPYOUTPUT \
	ratecontrol=$RATECONTROL \
	encodingpreset=$ENCODINGPRESET \
	maxbitrate=$MAXBITRATE \
	targetbitrate=$TARGETBITRATE  \
	intraframeinterval=$INTRAFRAMEINTERVAL \
	profile=$PROFILE \
	level=$LEVEL \
	entropy=$ENTROPY \
	t8x8intra=$T8X8INTRA \
	t8x8inter=$T8X8INTER \
	ddrbuf=$DDRBUF \
	ntemplayers=$NTEMPLAYERS \
	seqscaling=$SEQSCALING \
	qpintra=$QPINTRA \
	qpinter=$QPINTER \
	rcalgo=$RCALGO \
	airrate=$AIRRATE \
	idrinterval=$IDRINTERVAL \
	bytestream=$BYTESTREAM \
	aud=$AUD \
	headers=$HEADERS \
    ! flvmux streamable=$STREAMABLE ! \
    rtmpsink location="$LOCATION playpath=$PLAYPATH live=$LIVE" sync=false > /dev/null &
