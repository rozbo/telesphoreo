pkg:extract
cd *
pkg:patch
make package
pkg: mkdir -p /Applications
pkg: cp -a Terminal.app /Applications
