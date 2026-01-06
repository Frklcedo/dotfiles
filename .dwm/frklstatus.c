#include <stddef.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include <unistd.h>
#include <dirent.h>

#define COLOR_ZERO ""
#define COLOR_ONE ""
#define COLOR_TWO ""
#define COLOR_THREE ""

typedef struct {
    unsigned long long rx_bytes;
    time_t timestamp;
} netstats_t;

void get_datetime(char *src, size_t size);
void get_mem(char *src, size_t size);
void get_netspeed(char *src, size_t size);
netstats_t get_last_netstats();
int set_last_netstats(netstats_t netstats);
char *get_active_interface();
void get_battery(char *src, size_t size);
int find_battery(char *bat, size_t size);
int find_battery_ac(char *ac, size_t size);
void get_vol(char *src);

int main(void)
{
    char battery[30] = "";
    char datetime[30] = "";
    char vol[30] = "";
    char mem[30] = "";
    char netspeed[30] = "";

    get_datetime(datetime, sizeof(datetime));
    get_netspeed(netspeed, sizeof(netspeed));
    get_mem(mem, sizeof(mem));
    get_battery(battery, sizeof(battery));

    /* while (1) { */
    /*     printf("%s%s%s%s\n", vol, netspeed, mem, datetime); */
    /*     sleep(1); */
    /* } */

    printf(
        "%s%s%s%s%s\n",
        battery,
        vol,
        netspeed,
        mem,
        datetime
    );

    return EXIT_SUCCESS;
}

void get_datetime(char *src, size_t size) 
{
    time_t now;
    struct tm *info;

    time(&now);
    info = localtime(&now);

    char *format = COLOR_ZERO "   󱑌 %d/%m/%Y %R ";
    strftime(src, size, format, info);
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

    char *format = COLOR_ONE "   %.1fG  %.1fG  ";
    snprintf(src, size, format, used_gb, total_gb);
    fflush(meminfo);
}

void get_netspeed(char *src, size_t size)
{
    char *iface = get_active_interface();
    if (!iface) {
        strcpy(src, COLOR_THREE "  󱘖 󰤭  ");
        return;
    }

    char path[256];

    snprintf(path, sizeof(path), "/sys/class/net/%s/wireless", iface);

    int is_wifi = access(path, F_OK) == 0;

    char *icon = is_wifi ? "󰤨" : "";
    double speed = 0;

    netstats_t netstats;
    netstats_t last_netstats;

    char err[256] = "";

    netstats.timestamp = time(NULL);

    snprintf(path, sizeof(path), "/sys/class/net/%s/statistics/rx_bytes", iface);
    FILE *f = fopen(path, "r");

    if (f) {
        fscanf(f, "%llu", &netstats.rx_bytes);
        fclose(f);
    }
    else {
        netstats.rx_bytes = 0;
        strcpy(err, "nonetstat");
    }

    last_netstats = get_last_netstats();

    if (last_netstats.timestamp > 0) {

        double elapsed = difftime(netstats.timestamp, last_netstats.timestamp);
        if (elapsed > 0) {

            speed = (netstats.rx_bytes - last_netstats.rx_bytes) / elapsed / 1024.0;
        }
        snprintf(err, sizeof(err), "%f", speed);
    }

    set_last_netstats(netstats);

    if (speed >= 1.0) {
        snprintf(src, size, COLOR_TWO "  ↓%.1fMB/s %s  ", speed, icon);
    } else if (speed > 0) {
        snprintf(src, size, COLOR_TWO "  ↓%.0fKB/s %s  ", speed * 1024, icon);
    } else if (speed == 0) {
        snprintf(src, size, COLOR_THREE "  ↓%.0fKB/s %s  ", speed * 1024, icon);
    } else {
        snprintf(src, size, COLOR_THREE "  %s %s %s  ", iface, err, icon);
    }
}

netstats_t get_last_netstats()
{
    netstats_t last_netstats = {0, 0};

    FILE *f = fopen("/tmp/last_netstats", "r");

    last_netstats.rx_bytes = 0;
    last_netstats.timestamp = 0;
    if (f) {
        fscanf(f, "%lu %llu", &last_netstats.timestamp, &last_netstats.rx_bytes);
        fclose(f);
    }

    return last_netstats;
}


int set_last_netstats(netstats_t netstats)
{
    FILE *f = fopen("/tmp/last_netstats", "w");

    if (!f) return 0;

    fprintf(f, "%lu %llu\n", netstats.timestamp, netstats.rx_bytes);
    fclose(f);

    return 1;
}

char *get_active_interface()
{
    DIR *dir = opendir("/sys/class/net");

    if (!dir) return NULL;

    struct dirent *entry;
    static char iface[32];
    char path[256];

    while ((entry = readdir(dir)) != NULL) {

        if (entry->d_name[0] == '.') continue;
        if (strcmp(entry->d_name, "lo") == 0) continue;

        snprintf(path, sizeof(path), "/sys/class/net/%s/operstate", entry->d_name);

        FILE *file = fopen(path, "r");

        if (!file) continue;

        char state[16];
        if (fscanf(file, "%15s", state) != 1) {
            fclose(file);
            continue;
        }
        fclose(file);
        if (strcmp(state, "up") == 0) {
            strcpy(iface, entry->d_name);
            closedir(dir);
            return iface;
        }
    }
    closedir(dir);
    return NULL;
}

void get_battery(char *src, size_t size)
{
    char ac[10];
    char bat[10];
    int capacity;
    int charging;
    char icon[32];

    if(
        !find_battery(bat, sizeof(bat)) ||
        !find_battery_ac(ac, sizeof(ac))
    ) {
        strcpy(src, "");
        return;
    }

    FILE *fp;

    char path[256];

    snprintf(path, sizeof(path), "/sys/class/power_supply/%s/online", ac);
    fp = fopen(path, "r");
    fscanf(fp, "%d", &charging);
    fclose(fp);

    snprintf(path, sizeof(path), "/sys/class/power_supply/%s/capacity", bat);
    fp = fopen(path, "r");
    fscanf(fp, "%d", &capacity);
    fclose(fp);

    if(capacity < 20) {
        strcpy(icon, "󰁺");
    }
    else if (capacity < 40) {
        strcpy(icon, "󰁽");
    }
    else if (capacity < 60) {
        strcpy(icon, "󰁾");
    }
    else if (capacity < 80) {
        strcpy(icon, "󰂀");
    }
    else if (capacity < 90) {
        strcpy(icon, "󰂂");
    }
    else {
        strcpy(icon, "󰁹");
    }

    char *format = " %d%% %s%s ";
    snprintf(src, size, format, capacity, icon, charging ? "": "");
}

int find_battery_ac(char *ac, size_t size)
{
    DIR *dir = opendir("/sys/class/power_supply");
    if (!dir) {
        return 0;
    }

    struct dirent *entry;
    while ((entry = readdir(dir)) != NULL) {
        if (
            strncmp(entry->d_name, "AC", 2) == 0 ||
            strncmp(entry->d_name, "ADP", 3) == 0 ||
            strncmp(entry->d_name, "ACAD", 4) == 0
        ) {
            snprintf(ac, size, "%s", entry->d_name);
            closedir(dir);
            return 1;
        }
    }
    closedir(dir);
    return 0;
}

int find_battery(char *bat, size_t size)
{
    DIR *dir = opendir("/sys/class/power_supply");
    if (!dir) {
        return 0;
    }

    struct dirent *entry;
    while ((entry = readdir(dir)) != NULL) {
        if (strncmp(entry->d_name, "BAT", 3) == 0) {
            snprintf(bat, size, "%s", entry->d_name);
            closedir(dir);
            return 1;
        }
    }
    closedir(dir);
    return 0;
}
