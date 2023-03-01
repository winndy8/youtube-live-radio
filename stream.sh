#! /bin/bash

VBR="1500k"
FPS="24"
QUAL="superfast"

YOUTUBE_URL="rtmp://a.rtmp.youtube.com/live2"
KEY="z5k3-8888-69qu-9999"

SOURCE="video.mp4"

ffmpeg \
    -i "$SOURCE" -deinterlace \
    -vcodec libx264 -pix_fmt yuv420p -preset $QUAL -r $FPS -g $(($FPS * 2)) -b:v $VBR \
    -acodec libmp3lame -ar 44100 -threads 6 -qscale 3 -b:a 712000 -bufsize 512k \
    -f flv "$YOUTUBE_URL/$KEY"
