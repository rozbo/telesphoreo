tar -zxvf "${PKG_DATA}/odcctools-209.tgz"
cd odcctools
rm -f include/mach/machine/{boolean,exception,kern_return,processor_info,thread_state,thread_status,vm_param,vm_types}.h
rm -f include/mach/{task,thread_act,thread_status}.h include/mach/machine/rpc.h
pkg:patch
pkg:configure
make
pkg:install
