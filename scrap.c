#include <stdio.h>
#include <stdint.h>

typedef struct free_list_header
{
    struct free_list_header* next;
    struct free_list_header* prev;
    uint64_t size;
}free_list_header __attribute__((aligned(8)));

int main(int argc, char const *argv[])
{
    if((sizeof(free_list_header) % 8) == 0)
    {
        printf("Yes\n");
    }
    return 0;
}
