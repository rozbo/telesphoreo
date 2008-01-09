tar -zxvf "${PKG_DATA}/curl-7.17.1.tar.gz"
cd curl-7.17.1
pkg:patch
autoconf
pkg:configure ac_cv_file___dev_urandom_=yes
make
pkg:install
