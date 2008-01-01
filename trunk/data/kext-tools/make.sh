tar -zxvf "${PKG_DATA}/kext_tools-117.tar.gz"
cd kext_tools-117
cp -a "${PKG_DATA}/getiopolicy_np.c" .
#arm-apple-darwin-gcc -o kextload kextload_main.c  -framework CoreFoundation utility.c -framework IOKit getiopolicy_np.c -DPRIVATE
arm-apple-darwin-gcc -o kextstat kextstat_main.c
arm-apple-darwin-gcc -o kextfind kextfind_*.c  -framework IOKit -framework CoreFoundation QEQuery.c utility.c getiopolicy_np.c -DPRIVATE
arm-apple-darwin-gcc -I. -o kextunload kextunload_main.c  -framework CoreFoundation  -framework IOKit utility.c getiopolicy_np.c  -DPRIVATE
arm-apple-darwin-gcc -o kextlibs kextlibs_main.c -framework IOKit -framework CoreFoundation utility.c getiopolicy_np.c -DPRIVATE
arm-apple-darwin-gcc -o kextsymboltool kextsymboltool.c
arm-apple-darwin-gcc -o mkextunpack mkextunpack_main.c -framework CoreFoundation compression.c
#arm-apple-darwin-gcc -o kextd kextd_main.c -framework CoreFoundation -framework IOKit getiopolicy_np.c -DPRIVATE logging.c request.c PTLock.c watchvol.c bootcaches.c utility.c safecalls.c
#arm-apple-darwin-gcc -o kextcache kextcache_main.c -framework CoreFoundation -framework IOKit utility.c prelink.c mkext_file.c logging.c arch.c bootcaches.c compression.c safecalls.c update_boot.c getiopolicy_np.c -DPRIVATE
# XXX: these files shouldn't go in /usr/bin
pkg: mkdir -p /sbin /usr/bin /usr/sbin
pkg: cp -a kextfind kextlibs kextsymboltool /usr/bin
#pkg: cp -a kextd /usr/libexec
pkg: cp -a kextunload /sbin #kextload
pkg: cp -a mkextunpack kextstat /usr/sbin #kextcache
