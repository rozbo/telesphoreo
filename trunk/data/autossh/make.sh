pkg:setup
pkg:configure ac_cv_func_malloc_0_nonnull=yes ac_cv_func_realloc_0_nonnull=yes
make
pkg:install prefix="${PKG_DEST}/usr"
