pkg:extract
cd *
pkg:patch
autoconf
pkg:configure ac_cv_func_setpgrp_void=yes rb_cv_stack_grow_dir=-1 --disable-rpath --enable-shared
make
pkg:install
pkg: rm -rf /usr/share
