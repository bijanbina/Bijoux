#!/bin/bash

sh_Mute() 
{
    PAC_SNK=$(pacmd list-sink-inputs | grep -B 20 'media.name = "Spotify"')
    PAC_VOL=$(echo "$PAC_SNK" | grep "volume" | cut -d ' ' -f 6 | head -n 1)
    PAC_SNK=$(echo "$PAC_SNK" | grep "index" | cut -d ' ' -f 6)
    SP_COUNT=$(echo "$PAC_SNK" | wc -l)
    echo "$SP_COUNT"

    for (( i=1 ; i<=SP_COUNT ; i++ )); do

        SNK=$(echo "$PAC_SNK" | head -n $i | tail -n 1 )
	    echo "$i" "$SNK" "$PAC_VOL"
	    echo "$PAC_VOL" > /tmp/spotify_vol
	    pactl set-sink-input-volume $SNK 0%

    done
}

sh_UnMute() 
{
    PAC_VOL=$(cat /tmp/spotify_vol)
    PAC_SNK=$(pacmd list-sink-inputs | grep -B 20 'media.name = "Spotify"')
    PAC_SNK=$(echo "$PAC_SNK" | grep "index" | cut -d ' ' -f 6)
    SP_COUNT=$(echo "$PAC_SNK" | wc -l)

    for (( i=1 ; i<=SP_COUNT ; i++ )); do

        SNK=$(echo "$PAC_SNK" | head -n $i | tail -n 1)
        pactl set-sink-input-volume $SNK $PAC_VOL

    done

    rm /tmp/spotify_vol
}

DBUS_DEST="org.mpris.MediaPlayer2.spotify"
DBUS_NAME="/org/mpris/MediaPlayer2 org.freedesktop.DBus.Properties.Get"
DBUS_PROP="string:org.mpris.MediaPlayer2.Player string:Metadata"
DBUS_ARGS="--print-reply --dest=$DBUS_DEST $DBUS_NAME $DBUS_PROP"

TRACK=$(dbus-send $DBUS_ARGS | grep -A 1 "xesam:title" | tail -n 1 | cut -d'"' -f 2)

if [[ "$TRACK" == "Advertisement" ]]; then

	if [[ ! -f /tmp/spotify_vol ]]; then
	
		sh_Mute

	fi

elif [[ -f /tmp/spotify_vol ]]; then

    sh_UnMute

fi
