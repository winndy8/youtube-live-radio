#! /bin/bash

VBR="1000k"
FPS="24"
QUAL="superfast"

YOUTUBE_URL="rtmp://a.rtmp.youtube.com/live2"
KEY="513d-xphe-p2qt-v3w0-4bp3"

VIDEO_SOURCE="bg.mp4"
AUDIO_SOURCE="mp3/the-corner-in-the-town-121352-[AudioTrimmer.com].mp3"

  ffmpeg -loglevel info -y -re \
    -f image2 -loop 1 -i bg.mp4 \
    -f concat -safe 0 -i <((for f in ./mp3/*.mp3; do path="$PWD/$f"; echo "file ${path@Q}"; done) | shuf) \
    -c:v libx264 -preset veryfast -b:v 3000k -maxrate 3000k -bufsize 6000k \
    -framerate 25 -video_size 1280x720 -vf "format=yuv420p" -g 50 -shortest -strict experimental \
    -c:a aac -b:a 128k -ar 44100 \
    -f flv rtmp://a.rtmp.youtube.com/live2/$YOUTUBE_KEY
