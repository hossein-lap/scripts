#  _  _ ___    
# | || | __|   H
# | __ | _|    A
# |_||_|___|   P
#              

#!/bin/sh
set -e

scrCastMpeg () {
#    if [[ -d ~/scrRecs ]]; then
#        mkdir ~/scrRecs
#    fi
    local DemRes=$(xdpyinfo | grep dimensions | awk '{print $2;}')
    local Name=$(date +%Y-%m-%d_%H-%M-%S)

    ffmpeg \
        -f x11grab \
        -s ${DemRes} \
        -i :0.0 \
        -loglevel quiet -stats \
        ~/Videos/record/screen-${Name}.mkv
#        -f alsa \
#        -i default \

#        -c:v libx264 -r 30  \
#        -ac 1 \
#        -i hw:0 \
#        -acodec copy \
#        -i default \
#        -i /home/prime/musics/Musics/Boom\ 13-31\ 01Feb.mp3 \
#        $1 \
#        -f mp4 \
}

if [[ ! -d "$HOME/Videos/record/" ]]; then
	mkdir -pv ~/Videos/record/
fi

scrCastMpeg
