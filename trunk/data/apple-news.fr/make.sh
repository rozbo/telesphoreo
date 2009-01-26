pkg: mkdir -p /etc/apt/sources.list.d
pkg: cp -a %/apple-news.fr.list /etc/apt/sources.list.d
pkg: mkdir -p /Applications/Cydia.app/Sources
pkg: cp -a %/apple-news.fr.png /Applications/Cydia.app/Sources/apple-news.fr.png
