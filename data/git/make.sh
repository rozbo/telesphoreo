pkg:setup
pkg:configure ac_cv_c_c99_format=yes ac_cv_fread_reads_directories=no ac_cv_snprintf_returns_bogus=yes --without-tcltk
make
pkg:install