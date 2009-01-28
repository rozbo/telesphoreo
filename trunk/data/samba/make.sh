pkg:setup
cd source
./autogen.sh
pkg:configure samba_cv_CC_NEGATIVE_ENUM_VALUES=yes
make
pkg:install
pkg: rm -rf /usr/swat
