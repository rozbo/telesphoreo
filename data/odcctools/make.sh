pkg:setup
rm -f include/libkern/OSByteOrder.h
rm -f include/mach/{task,thread_act,thread_status}.h
rm -f include/mach/machine/{boolean,exception,kern_return,processor_info,rpc,thread_state,thread_status,vm_param,vm_types}.h
pkg:configure --disable-ld64 ac_cv_header_objc_objc_runtime_h=no
make
pkg:install
