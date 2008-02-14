pkg:extract
cd */build.unix
PKG_CONF=../dist/configure pkg:configure vi_cv_sprintf_count=yes vi_cv_sys5_pty=no
make
pkg:install
pkg: mkdir -p /etc/profile.d
pkg: cp -a %/nvi.sh /etc/profile.d
