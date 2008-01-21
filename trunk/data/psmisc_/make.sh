tar -zxvf "${PKG_DATA}/psmisc-22.6.tar.gz"
cd psmisc-22.6
pkg:patch
automake
pkg:configure ac_cv_func_malloc_0_nonnull=yes ac_cv_func_realloc_0_nonnull=yes
make
pkg:install
pkg: rm -f /usr/bin/killall
