pkg:extract
cd *
pkg:patch
autoconf
pkg:configure ac_cv_type_sa_family_t=yes ac_cv_type_socklen_t=yes ac_cv_member_struct_utmp_ut_user=yes ac_cv_func_obstack=no
make
pkg:install
