pkg:extract
pkg: mkdir -p /usr/share /usr/bin
pkg: cp -a * /usr/share/msf3
pkg: find / -name '.svn' -prune -exec rm -rfv {} \;
pkg: "${PKG_TARG}-gcc" -o /usr/share/msf3/data/templates/template_armle_darwin.bin /usr/share/msf3/data/templates/template.c
ln -s /usr/share/msf3/msfcli "${PKG_DEST}"/usr/bin/msfcli
ln -s /usr/share/msf3/msfconsole "${PKG_DEST}"/usr/bin/msfconsole
ln -s /usr/share/msf3/msfelfscan "${PKG_DEST}"/usr/bin/msfelfscan
ln -s /usr/share/msf3/msfencode "${PKG_DEST}"/usr/bin/msfencode
ln -s /usr/share/msf3/msfmachscan "${PKG_DEST}"/usr/bin/msfmachscan
ln -s /usr/share/msf3/msfpayload "${PKG_DEST}"/usr/bin/msfpayload
ln -s /usr/share/msf3/msfpescan "${PKG_DEST}"/usr/bin/msfpescan
