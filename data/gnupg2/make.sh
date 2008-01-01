pkg:extract
cd *
pkg:patch
autoconf
pkg:configure --with-{ksba,libassuan,pth}-prefix="${PKG_ROOT}"/usr --sysconfdir=/etc
make
pkg:install
