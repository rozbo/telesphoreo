pkg:extract
cd *
pkg:patch
pkg:configure ac_cv_type_wint_t=yes ac_cv_prog_AR=$(which arm-apple-darwin-ar)
make AR=arm-apple-darwin-ar
pkg:install
