#!/usr/libexec/cydia_/bash

shopt -s extglob nullglob
export PATH=/usr/libexec/cydia_

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

    if [[ $((used + 524288)) -lt ${free} ]]; then
        base=$(basename "${dir}")

        new=/var/${base}
        if [[ -e ${new} ]]; then
            new=$(godmode mktemp -d cydia.XXXXXX)
        fi

        godmode mv -T "${dir}" "${new}"
        godmode ln -s "${new}" "${dir}"
    fi
fi; done

[[ $(df_ /) -gt 35651584 && $(df_ /var) -gt 35651584 ]]
