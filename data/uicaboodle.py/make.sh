${PKG_TARG}-gcc -o _uicaboodle.dylib "${PKG_DATA}/uicaboodle.m" -I"${PKG_ROOT}"/usr/include/python2.5 -I "$(PKG_WORK_ pyobjc)"/*/pyobjc-core/Modules/objc -lpython2.5 -framework UIKit -dynamiclib -framework Foundation
pkg: mkdir -p /usr/lib/python2.5/lib-dynload
pkg: cp -a _uicaboodle.dylib /usr/lib/python2.5/lib-dynload
