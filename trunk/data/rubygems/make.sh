shopt -s extglob
pkg:extract
cd *
ruby setup.rb --prefix="${PKG_DEST}/usr"
pkg: sed -i -e 's/^#!.*/#!\/usr\/bin\/ruby/' /usr/bin/gem /usr/bin/update_rubygems
pkg: mkdir -p /usr/lib/ruby/site_ruby/1.8
mv "${PKG_DEST}"/usr/lib/!(ruby) "${PKG_DEST}"/usr/lib/ruby/site_ruby/1.8
