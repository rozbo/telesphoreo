pkg:setup
pkg:configure ac_cv_c_c99_format=yes ac_cv_fread_reads_directories=no ac_cv_snprintf_returns_bogus=yes --without-tcltk
make
pkg:install
pkg: sed -i -e 's/^=head2 .*:/=head2/' /usr/lib/perl/5.8.8/perllocal.pod
