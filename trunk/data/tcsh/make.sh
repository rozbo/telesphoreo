pkg:extract
cd *
pkg:patch
pkg:configure ac_cv_func_setpgrp_void=yes
make
pkg:install
