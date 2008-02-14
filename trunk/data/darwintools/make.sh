pkg:extract
cd *
pkg: mkdir -p /usr/bin

for tool in startupfiletool sw_vers; do
    arm-apple-darwin-gcc -o "${tool}" "${tool}.c" -framework CoreFoundation
    pkg: cp -a "${tool}" /usr/bin
done
