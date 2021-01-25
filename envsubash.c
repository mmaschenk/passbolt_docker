#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <pwd.h>


void showid() {
  int real = getuid();
  int euid = geteuid();
  printf("The REAL UID =: %d\n", real);
  printf("The EFFECTIVE UID =: %d\n", euid);
}

int main(int argc, char** argv) {
    int effuid = geteuid();
    struct passwd pwd;
    struct passwd *result;
    char *buf;
    int bufsize = 16000;

    char *newarg[argc+1] ;

    for (int i=0;i<argc;i++) { newarg[i] = argv[i]; }
    newarg[argc] = NULL;

    buf = malloc(bufsize);
           if (buf == NULL) {
               perror("malloc");
               exit(1);
           }

    int s = getpwuid_r(effuid, &pwd, buf, bufsize, &result);

    setreuid( effuid, effuid);
    /*showid();*/
    char homedir[200];
    snprintf(homedir, 200, "HOME=%s", pwd.pw_dir );

    char username[200];
    snprintf(username, 200, "USER=%s", pwd.pw_name );

    char logname[200];
    snprintf(logname, 200, "LOGNAME=%s", pwd.pw_name );

    char shell[200];
    snprintf(shell, 200, "SHELL=%s", pwd.pw_shell );
    char *env[] = {
      logname,
      username,
      homedir,
      NULL
    };

    argv[0] = "-";

    chdir(pwd.pw_dir);
    int r =  execve("/bin/bash", argv, env);
    perror("Error");
}
