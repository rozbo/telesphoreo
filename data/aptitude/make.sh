shopt -s extglob
pkg:setup
pkg:configure
pkg:make
pkg:install
rm -f "${PKG_DEST}"/usr/share/aptitude/!(aptitude-defaults|section-descriptions) #function_groups|function_pkgs
