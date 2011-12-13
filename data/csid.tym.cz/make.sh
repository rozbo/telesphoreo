pkg: mkdir -p /etc/apt/sources.list.d
pkg: cp -a %/csid.tym.cz.list /etc/apt/sources.list.d
pkg: mkdir -p /Applications/Cydia.app/Sources
pkg: cp -a %/"CZ-SK community.png" /Applications/Cydia.app/Sources/csrepo.co.cc.png
