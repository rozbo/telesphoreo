pkg:extract
cd *
pkg:patch
pkg:configure ac_cv_func_obstack=no
make
pkg:install
