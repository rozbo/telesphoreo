tar -zxvf "${PKG_DATA}/bash-3.2.tar.gz"
cd bash-3.2
pkg:configure bash_cv_dev_fd=absent bash_cv_sys_named_pipes=present bash_cv_job_control_missing=missing
make
pkg:install
pkg:bin bash
ln -s bash "${PKG_DEST}/bin/sh"
