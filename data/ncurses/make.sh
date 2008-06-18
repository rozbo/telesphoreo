shopt -s extglob
pkg:setup
cd ..
dir=$(echo *)
mkdir bld-ncurses{,w}
cd bld-ncurses
flags='--with-shared --without-normal --without-debug --enable-sigwinch'
PKG_CONF=../${dir}/configure pkg:configure ${flags}
make
pkg:install
cd ../bld-ncursesw
PKG_CONF=../${dir}/configure pkg:configure ${flags} --disable-overwrite --enable-widec
make
pkg:install

for ti in "${PKG_DEST}"/usr/share/terminfo/*/*; do
    if [[ ${ti} == */@(?(pc)ansi|cons25|cygwin|dumb|linux|mach|rxvt|screen|sun|vt@(52|100|102|220)|swvt25?(m)|[Ex]term)?(-*) ]]; then
        echo "keeping terminfo: ${ti}"
    else
        rm -f "${ti}"
    fi
done

rmdir --ignore-fail-on-non-empty "${PKG_DEST}"/usr/share/terminfo/*
