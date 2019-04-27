/**
 * Task II
 *
 * This program should be executed whenever the computer is booted. It checks
 * whether the worm is running or not for every 60 seconds. This program itself
 * does not perform any payload.
 */

#include <stdlib.h>
#include <unistd.h>
#include <string>
#define MINUTE 60 * 1000 * 1000

// Queries if the worm programming is running.
bool isWormRunning() {
    // TODO
    return false;
}

// Queries any location the worm binary is repalced. If no bin file exists,
// return empty string.
std::string isWormDistributed() {
    // TODO

    return "";
}

// Executes the worm placed at given location
void runWorm(std::string loc) {
    // TODO
}

int main() {
    while (1) {
        if (!isWormRunning()) {
            std::string path = isWormDistributed();
            if (path == "") return -1;
            runWorm(path);
        }
        usleep(MINUTE);
    }
    return -1;  // should not end
}