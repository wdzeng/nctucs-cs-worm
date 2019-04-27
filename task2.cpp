#include <unistd.h>
#define MINUTE 60 * 1000 * 1000

bool isWormRunning() {
    // TODO
}

void runWorm() {
    // TODO
}

int main() {
    while (1) {
        if (!isWormRunning()) {
            runWorm();
        }
        usleep(MINUTE);
    }

    return 0;
}