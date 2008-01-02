pkg:extract
cd *
pkg:patch
pkg:configure ac_cv_va_copy=yes --enable-static=no
make
pkg:install
