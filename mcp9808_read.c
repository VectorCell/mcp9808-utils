#include "mcp9808.h"
#include <unistd.h>
#include <stdio.h>

int main(int argc, char **argv)
{
    char *i2c_path = "/dev/i2c-1";
    int address = 0x18;

    void *unit = mcp9808_init(address, i2c_path);
    if (unit) {
        float t = mcp9808_temperature(unit);
        printf("%0.1f\n", t);
        mcp9808_close(unit);
    } else {
        printf("ERROR: unable to instantiate mcp9808 unit\n");
    }

    return 0;
}
