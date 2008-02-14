pkg:extract
cd *
pkg:patch
cd pyobjc-core

$(arm-apple-darwin-gcc -print-prog-name=cc1obj) -print-objc-runtime-info <(echo) >Modules/objc/objc-runtime-info.h

find Modules/objc -name '*.m' -print0 | while read -d $'\0' -r m; do
    o=${m%.m}.o
    mi=${m%.m}.mi
    arm-apple-darwin-gcc -O0 -g3 -I"${PKG_ROOT}"/usr/include/{libxml2,python2.5} -ObjC -c -o "$o" "$m" -DNO_OBJC2_RUNTIME -IModules/objc -fno-common
done

arm-apple-darwin-gcc -O0 -g3 -dynamiclib -lpython2.5 -o _objc.dylib Modules/objc/*.o -lobjc -lffi -lxml2 -framework CoreFoundation -framework Foundation

pkg: mkdir -p /usr/lib/python2.5/lib-dynload
pkg: cp -a _objc.dylib /usr/lib/python2.5/lib-dynload
pkg: cp -a Lib/objc /usr/lib/python2.5
