pkg: svn co http://metasploit.com/svn/framework3/trunk/ framework-3.1
pkg: mkdir -p /var/local /usr/bin
pkg: cp -a framework-3.1 /var/local/msf3
pkg: ln -s /var/local/msf3/msfcli /usr/bin/msfcli
pkg: ln -s /var/local/msf3/msfconsole /usr/bin/msfconsole
pkg: ln -s /var/local/msf3/msfd /usr/bin/msfd
pkg: ln -s /var/local/msf3/msfencode /usr/bin/msfencode
pkg: ln -s /var/local/msf3/msfgui /usr/bin/msfgui
pkg: ln -s /var/local/msf3/msfopcode /usr/bin/msfopcode
pkg: ln -s /var/local/msf3/msfpayload /usr/bin/msfpayload
pkg: ln -s /var/local/msf3/msfpescan /usr/bin/msfpescan
pkg: ln -s /var/local/msf3/msfweb /usr/bin/msfweb
