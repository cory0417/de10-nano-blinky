#include <error.h>
#include <fcntl.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <unistd.h>
#include "hps_0.h"

#define HPS2FPGASLAVES 0xFF200000
#define BRIDGE_SPAN 0x6000

int main(int argc, char **argv)
{
    uint32_t delay_cycles = 0;
    uint32_t pulse_width_cycles = 0;

    uint8_t *start_map = NULL;
    uint8_t *delay_cycles_map = NULL;
    uint8_t *pulse_width_cycles_map = NULL;

    uint8_t *bridge_map = NULL;

    int fd = 0;
    int result = 0;

    if (argc != 3)
    {
        perror("Only 2 numbers should be passed.");
        return -1;
    }

    delay_cycles = strtoul(argv[1], NULL, 10);
    pulse_width_cycles = strtoul(argv[2], NULL, 10);

    fd = open("/dev/mem", O_RDWR | O_SYNC);

    if (fd < 0)
    {
        perror("Couldn't open /dev/mem\n");
        return -2;
    }

    printf("Trying to map");
    bridge_map = (uint8_t *)mmap(NULL, BRIDGE_SPAN, PROT_READ | PROT_WRITE, MAP_SHARED, fd, HPS2FPGASLAVES);
    printf("Done mapping");
    if (bridge_map == MAP_FAILED)
    {
        perror("mmap failed.");
        return -3;
    }
    printf("Trying to write");
    start_map = bridge_map + PULSE_START_PIO_BASE;
    delay_cycles_map = bridge_map + PULSE_DELAY_PIO_BASE;
    pulse_width_cycles_map = bridge_map + PULSE_WIDTH_PIO_BASE;
    *((uint8_t *)start_map) = 0;
    *((uint32_t *)delay_cycles_map) = delay_cycles;
    *((uint32_t *)pulse_width_cycles_map) = pulse_width_cycles;
    *((uint8_t *)start_map) = 1;
    printf("Pulse generator started.\n");
    printf("Delay cycles: %d\n", delay_cycles);
    printf("Pulse width cycles: %d\n", pulse_width_cycles);
    // Wait for pulse to finish
    result = munmap(bridge_map, BRIDGE_SPAN);
    if (result < 0)
    {
        perror("Couldn't unmap bridge.");
        close(fd);
        return -4;
    }

    close(fd);
    return 0;
}