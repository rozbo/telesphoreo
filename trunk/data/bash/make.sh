pkg:setup
pkg:configure bash_cv_dev_fd=absent bash_cv_sys_named_pipes=present bash_cv_job_control_missing=present bash_cv_func_sigsetjmp=present bash_cv_func_ctype_nonascii=no bash_cv_must_reinstall_sighandlers=no bash_cv_func_strcoll_broken=yes ac_cv_c_stack_direction=-1 ac_cv_func_mmap_fixed_mapped=yes gt_cv_int_divbyzero_sigfpe=no ac_cv_func_setvbuf_reversed=no ac_cv_func_strcoll_works=yes ac_cv_func_working_mktime=yes ac_cv_type_getgroups=gid_t bash_cv_dup2_broken=no
#pgrp_pipe...
make
pkg:install
pkg:bin bash
ln -s bash "${PKG_DEST}/bin/sh"
