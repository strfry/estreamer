#!/bin/sh

gst-launch-1.0 udpsrc address=localhost port=1234 ! 'application/x-rtp,payload=96,encoding-name=H264'! rtph264depay ! decodebin ! glimagesink
