pkg:extract
cd *
pkg:patch
cd src
pkg:configure ac_cv_func_regcomp=yes ac_cv_printf_positional=yes ac_cv_file__etc_environment=no ac_cv_file__etc_TIMEZONE=no ac_cv_prog_AR="$(which arm-apple-darwin-ar)" krb5_cv_attr_constructor_destructor=yes,yes
make LIBRESOLV='-dylib_file /usr/lib/libresolv.dylib:${PKG_ROOT}/usr/lib/libresolv.dylib'
pkg:install
