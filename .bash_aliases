alias 192='RATE=192;mkdir $RATE;for file in *.mp3 ; do lame -b 192 "./$file" "./$RATE/$file"; done'
alias flac2mp3='install -d ./mp3 && for file in *.flac; do lame -V0 "$file" "mp3/${file%.*}".mp3; done'
alias wav2mp3='install -d ./mp3 && for file in *.wav; do lame -V0 "$file" "mp3/${file%.*}".mp3; done'

function video2mp4 {
    FILE="$1"
    FILENAME="${FILE%.*}.mp4"

    ffmpeg -i "${FILE}" -vf "scale=iw/2:ih/2" -c:v libx264 -preset slow -b:v 500k -c:a aac -b:a 128k "${FILENAME}"
}
export -f video2mp4

function telegram_voice {
    FILE="$1"
    FILENAME="${FILE%.*}.ogg"

    if type opusenc; then
        ffmpeg -loglevel error -i "${FILE}" -f wav - | opusenc - --downmix-mono --bitrate 60 /tmp/"${FILENAME}"
    else
        ffmpeg -loglevel error -y -i "${FILE}" -f opus -b:a 60k /tmp/"${FILENAME}"
    fi

    echo /tmp/"${FILENAME}"
}
