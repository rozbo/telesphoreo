tar -zxvf "${PKG_DATA}/bootstrap_cmds-60.tar.gz"
cd bootstrap_cmds-60
pkg:patch
cd migcom.tproj
cat >ident.c <<EOF
char *MigGenerationDate = "`date`";
char *MigMoreData = "`whoami`@`hostname`";
EOF
cp -a i386 arm
yacc -d parser.y -o parser.c
lex lexxer.l
arm-apple-darwin-gcc -o migcom *.c
pkg: mkdir -p /usr/bin /usr/libexec
pkg: cp -a migcom /usr/libexec
pkg: cp -a mig.sh /usr/bin/mig
