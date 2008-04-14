pkg:setup
pkg:configure ac_cv_file___dev_urandom_=yes ac_cv_file___dev_ptmx_=yes ac_cv_file___dev_ptc_=no --with-ssl="${PKG_ROOT}/usr"
touch stunnel.pem
make openssl="$(which openssl)"
make install prefix="${PKG_DEST}/usr"
