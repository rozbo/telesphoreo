pkg: mkdir -p /etc/apt/sources.list.d
pkg: cp -a %/macciti.com.list /etc/apt/sources.list.d
pkg: mkdir -p /Applications/Cydia.app/Sources
pkg: cp -a %/MacCiti.png /Applications/Cydia.app/Sources/macciti.com.png
