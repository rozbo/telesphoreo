pkg:setup
cd src
"${PKG_TARG}-gcc" -o class-dump -ObjC *.m -Wall -include Foundation/Foundation.h -framework CoreFoundation -framework Foundation -lobjc -save-temps
pkg: mkdir -p /usr/bin
pkg: cp -a class-dump /usr/bin
