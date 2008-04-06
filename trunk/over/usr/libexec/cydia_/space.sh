#!/usr/libexec/cydia_/bash
export PATH=/usr/libexec/cydia_

for dir in \
    /Applications \
    /Library/Ringtones \
    /Library/Wallpaper \
    /System/Library/Fonts \
    /usr/share
do
    . /usr/libexec/cydia/move.sh "${dir}" /var/"$(basename "${src}")"
done

[[ $(df_ /) -gt 35651584 && $(df_ /var) -gt 35651584 ]]
