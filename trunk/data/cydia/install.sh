#!/bin/bash

shopt -s extglob nullglob

function df_() {
    free=$(df -B1 "$1")
    free=${free% *%*}
    free=${free%%*( )}
    free=${free##* }
    echo "${free}"
}

for dir in \
    /Applications \
    /Library/Ringtones \
    /Library/Wallpaper \
    /System/Library/Fonts \
    /usr/share
do if [[ -d ${dir} && ! -h ${dir} ]]; then
    used=$(du -bs "${dir}")
    used=${used%%$'\t'*}
    free=$(df_ /var)

    if [[ ${used} -lt ${free} ]]; then
        base=$(basename "${dir}")

        new=/var/${base}
        if [[ -e ${new} ]]; then
            new=$(TMPDIR=/var mktemp -t /var -d cydia.XXXXXX)
        fi

        mv -T "${dir}" "${new}"
        ln -s "${new}" "${dir}"
    fi
fi; done

[[ $(df_ /) -gt 33554432 && $(df_ /var) -gt 33554432 ]]
