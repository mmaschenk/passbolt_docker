#include <stdio.h>
#include <unistd.h>


void showid() {
  int real = getuid();
  int euid = geteuid();
  printf("The REAL UID =: %d\n", real);
  printf("The EFFECTIVE UID =: %d\n", euid);
}

int main(int argc, char** argv) {
    int effuid = geteuid();

    setreuid( effuid, effuid);
    /*showid();*/
    return execv("/bin/bash", argv);    
}
