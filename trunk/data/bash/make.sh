pkg:extract
cd *
pkg:patch
pkg:configure bash_cv_dev_fd=absent bash_cv_sys_named_pipes=present bash_cv_job_control_missing=missing
make
pkg:install
pkg:bin bash
ln -s bash "${PKG_DEST}/bin/sh"
