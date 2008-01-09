pkg:extract
cd *
pkg:configure --enable-malloc0returnsnull
make
pkg:install
