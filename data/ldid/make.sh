pkg:setup
"${PKG_TARG}-g++" -I . -o util/ldid{,.cpp} -x c util/{lookup2,sha1}.c
pkg: mkdir -p /usr/bin
pkg: cp -a util/ldid /usr/bin
