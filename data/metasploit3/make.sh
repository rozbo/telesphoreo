pkg:extract
pkg: mkdir -p /usr/share /usr/bin
pkg: cp -a * /usr/share/msf3
pkg: chmod 755 /usr/share/msf3/msfelfscan
ln -s /usr/share/msf3/msfcli "${PKG_DEST}"/usr/bin/msfcli
ln -s /usr/share/msf3/msfconsole "${PKG_DEST}"/usr/bin/msfconsole
ln -s /usr/share/msf3/msfd "${PKG_DEST}"/usr/bin/msfd
ln -s /usr/share/msf3/msfelfscan "${PKG_DEST}"/usr/bin/msfelfscan
ln -s /usr/share/msf3/msfencode "${PKG_DEST}"/usr/bin/msfencode
ln -s /usr/share/msf3/msfgui "${PKG_DEST}"/usr/bin/msfgui
ln -s /usr/share/msf3/msfopcode "${PKG_DEST}"/usr/bin/msfopcode
ln -s /usr/share/msf3/msfpayload "${PKG_DEST}"/usr/bin/msfpayload
ln -s /usr/share/msf3/msfpescan "${PKG_DEST}"/usr/bin/msfpescan
ln -s /usr/share/msf3/msfweb "${PKG_DEST}"/usr/bin/msfweb