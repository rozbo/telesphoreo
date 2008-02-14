#include <unistd.h>

int main(int argc, const char *argv[]) {
    unlink(argv[2]);
    symlink(argv[1], argv[2]);
    return 0;
}
