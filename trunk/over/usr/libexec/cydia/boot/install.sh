#!/usr/libexec/cydia/boot/bash

shopt -s extglob nullglob
export PATH=/usr/libexec/cydia/boot

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
            new=$(mktemp -d cydia.XXXXXX)
        fi

        godmode mv -T "${dir}" "${new}"
        godmode ln -s "${new}" "${dir}"
    fi
fi; done

[[ $(df_ /) -gt 33554432 && $(df_ /var) -gt 33554432 ]]
