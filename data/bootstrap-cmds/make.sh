pkg:setup
cd migcom.tproj
cat >ident.c <<EOF
char *MigGenerationDate = "`date`";
char *MigMoreData = "`whoami`@`hostname`";
EOF
cp -a i386 arm
yacc -d parser.y -o parser.c
lex lexxer.l
${PKG_TARG}-gcc -o migcom *.c
pkg: mkdir -p /usr/bin /usr/libexec
pkg: cp -a migcom /usr/libexec
pkg: cp -a mig.sh /usr/bin/mig
