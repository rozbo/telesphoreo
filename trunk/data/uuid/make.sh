pkg:extract
cd *
pkg:patch
pkg:configure ac_cv_va_copy=yes
make
pkg:install
