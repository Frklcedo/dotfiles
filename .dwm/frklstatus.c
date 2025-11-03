
#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>

void get_datetime(char *src, size_t size);
void get_mem(char *src, size_t size);
void get_vol(char *src);
void get_getnetspeed(char *src);

int main(void)
{
    char datetime[30] = "";
    char vol[30] = "";
    char mem[30] = "";
    char netspeed[30] = "";

    get_datetime(datetime, sizeof(datetime));
    get_mem(mem, sizeof(mem));

    while (1) {
        printf("%s%s%s%s\n", vol, netspeed, mem, datetime);
        sleep(1);
    }

    return EXIT_SUCCESS;
}

void get_datetime(char *src, size_t size) 
{
    time_t now;
    struct tm *info;

    time(&now);
    info = localtime(&now);

    strftime(src, size, "󱑌 %d/%m/%Y %R", info);
}

void get_mem(char *src, size_t size)
{
    long available = 0, used = 0, total = 0;
    char key[64];
    long value;
    char unit[8];
    int read = 0;
    FILE *meminfo = fopen("/proc/meminfo", "r");
    if (!meminfo) {
       return;
    }
    while (fscanf(meminfo, "%63s %ld %7s", key, &value, unit)) {
        if (strcmp(key, "MemTotal:") == 0) {
            total = value;
            read++;
        }
        else if (strcmp(key, "MemAvailable:") == 0) {
            available = value;
            read++;
        }
        if (read > 1) {
           break;
        }
    }

    fclose(meminfo);

    double used_gb = ( total - available ) / ( 1024.0 * 1024.0 );
    double total_gb = total / ( 1024.0 * 1024.0 );

    snprintf(src, size, " %.1fG  %.1fG ", used_gb, total_gb);
    fflush(meminfo);
}
