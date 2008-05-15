pkg:setup
cd ..
dir=$(echo *)
mkdir bld-ncurses{,w}
cd bld-ncurses
PKG_CONF=../${dir}/configure pkg:configure --with-shared --without-normal --without-debug --enable-sigwinch
make
pkg:install
cd ../bld-ncursesw
PKG_CONF=../${dir}/configure pkg:configure --with-shared --without-normal --without-debug --enable-sigwinch --disable-overwrite --enable-widec
make
pkg:install
