#!/bin/bash

# This script allows the user to select a free playlists provided by di.fm by
# specifying a number as an argument.
# Thanks to Chris Willig for the original idea!

function show_usage {
    echo "Usage: di.sh [OPTION] ... [CHOICE]"
    echo "Play a playlist file from di.fm"
    echo "CHOICE is an integer in the range [1,46]"
    echo "Example: di.sh 3"
    echo
    echo "CHOICES:"
    echo "   1: Deep House"
    echo "   2: Epic Trance"
    echo "   3: Hands Up"
    echo "   4: Club Dubstep"
    echo "   5: Progressive Psy"
    echo "   6: Trance"
    echo "   7: Vocal Trance"
    echo "   8: Lounge"
    echo "   9: Chillout"
    echo "  10: Vocal Chillout"
    echo "  11: House"
    echo "  12: Progressive"
    echo "  13: Minimal"
    echo "  14: Hard Dance"
    echo "  15: EuroDance"
    echo "  16: Electro House"
    echo "  17: Tech House"
    echo "  18: PsyChill"
    echo "  19: Goa-Psy Trance"
    echo "  20: Hardcore"
    echo "  21: DJ Mixes"
    echo "  22: Ambient"
    echo "  23: Drum 'n Bass"
    echo "  24: Classic Electronica"
    echo "  25: UK Garage"
    echo "  26: Breaks"
    echo "  27: Cosmic Downtempo"
    echo "  28: Techno"
    echo "  29: Soulful House"
    echo "  30: Future Synthpop"
    echo "  31: Tribal House"
    echo "  32: Funky House"
    echo "  33: Deep Nu-Disco"
    echo "  34: Space Dreams"
    echo "  35: Hardstyle"
    echo "  36: Chillout Dreams"
    echo "  37: Liquid DnB"
    echo "  38: Classic EuroDance"
    echo "  39: Club Sounds"
    echo "  40: Classic Trance"
    echo "  41: Classic Vocal Trance"
    echo "  42: Dubstep"
    echo "  43: Disco House"
    echo "  44: Latin House"
    echo "  45: Oldschool Acid"
    echo "  46: Chiptunes"
}

function get_playlist {
# pick the right part of the URL based on the user's command line choice
    case $1 in 
        1)
            STREAM=deephouse
            ;;
        2)
            STREAM=epictrance
            ;;
        3)
            STREAM=handsup
            ;;
        4)
            STREAM=clubdubstep
            ;;
        5)
            STREAM=progressiveplay
            ;;
        6)
            STREAM=trance
            ;;
        7)
            STREAM=vocaltrance
            ;;
        8)
            STREAM=lounge
            ;;
        9)
            STREAM=chillout
            ;;
        10)
            STREAM=vocalchillout
            ;;
        11)
            STREAM=house
            ;;
        12)
            STREAM=progressive
            ;;
        13)
            STREAM=minimal
            ;;
        14)
            STREAM=harddance
            ;;
        15)
            STREAM=eurodance
            ;;
        16)
            STREAM=electro
            ;;
        17)
            STREAM=techhouse
            ;;
        18)
            STREAM=psychill
            ;;
        19)
            STREAM=goapsy
            ;;
        20)
            STREAM=hardcore
            ;;
        21)
            STREAM=djmixes
            ;;
        22)
            STREAM=ambient
            ;;
        23)
            STREAM=drumandbass
            ;;
        24)
            STREAM=classictechno
            ;;
        25)
            STREAM=ukgarage
            ;;
        26)
            STREAM=breaks
            ;;
        27)
            STREAM=cosmicdowntempo
            ;;
        28)
            STREAM=techno
            ;;
        29)
            STREAM=soulfulhouse
            ;;
        30)
            STREAM=futuresynthpop
            ;;
        31)
            STREAM=tribalhouse
            ;;
        32)
            STREAM=funkyhouse
            ;;
        33)
            STREAM=deepnudisco
            ;;
        34)
            STREAM=spacemusic
            ;;
        35)
            STREAM=hardstyle
            ;;
        36)
            STREAM=chilloutdreams
            ;;
        37)
            STREAM=liquiddnb
            ;;
        38)
            STREAM=classiceurodance
            ;;
        39)
            STREAM=club
            ;;
        40)
            STREAM=classictrance
            ;;
        41)
            STREAM=classicvocaltrance
            ;;
        42)
            STREAM=dubstep
            ;;
        43)
            STREAM=discohouse
            ;;
        44)
            STREAM=latinhouse
            ;;
        45)
            STREAM=oldschoolacid
            ;;
        46)
            STREAM=chiptunes
            ;;
    esac
}

# in case C-c is hit somehow, delete the temporary playlist file
trap "[ -f $TEMP_PLS ] && rm $TEMP_PLS" SIGINT SIGTERM

# croak if no playlist number is given
if [ $# -lt 1 ] ; then
    show_usage
fi

# determine which playlist the user has chosen
get_playlist $1

# try to come up with a name that doesn't already exist as a file
TEMP_PLS=/tmp/.${STREAM}.pls.${RANDOM}
# keep trying until you come up with a file that doesn't already exist
until [ ! -e $TEMP_PLS ]
do 
    TEMP_PLS=/tmp/.${STREAM}.pls.${RANDOM}
done

# download the playlist file and give it a name that hasn't been defined yet
wget -O $TEMP_PLS listen.di.fm/public3/${STREAM}.pls && 
  mplayer -playlist $TEMP_PLS

# remove the temporary playlist file
rm $TEMP_PLS
