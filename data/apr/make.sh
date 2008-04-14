pkg:setup
pkg:configure --disable-static ac_cv_file__dev_zero=yes ac_cv_func_setpgrp_void=yes apr_cv_process_shared_works=yes apr_cv_mutex_robust_shared=no apr_cv_tcp_nodelay_with_cork=no
make
pkg:install
