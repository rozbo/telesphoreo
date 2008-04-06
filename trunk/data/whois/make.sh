pkg:extract
cd *
make CC="${PKG_TARG}-gcc"
pkg:usrbin whois
