#include "include/native.h"
#include <string.h>

uint64_t subr(GoSlice *slice)
{
    static char msg[] = "hello world";
    if (!slice) return -1;
    char *data = slice->data;
    if (!data) return -2;
    if (sizeof msg > slice->cap) return -3;

    memset(data, '\0', slice->cap);

    int nb = 0;
    while (nb < sizeof msg)
    {
        data[nb] = msg[nb];
        nb++;
    }

    return nb;
}