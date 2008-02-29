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

function mv_() {
    src=$1
    dst=/var/$(basename "${src}")

    if [[ -e ${dst} ]]; then
        dst=$(mktemp -d /var/cydia.XXXXXX)
    else
        mkdir -p "${dst}"
    fi

    if [[ -e ${src} ]]; then
        chmod --reference="${src}" "${dst}"
        chown --reference="${src}" "${dst}"

        cp -aT "${src}" "${dst}" || {
            rm -rf "${dst}"
            exit 1
        }

        rm -rf "${src}"
    else
        chmod 775 "${dst}"
        chown root.admin "${dst}"
    fi

    ln -s "${dst}" "${src}"
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
        mv_ "${dir}"
    fi
elif [[ -h ${dir} && ! -e ${dir} ]]; then
    rm -f "${dir}"
    mv_ "${dir}"
fi; done

[[ $(df_ /) -gt 35651584 && $(df_ /var) -gt 35651584 ]]
