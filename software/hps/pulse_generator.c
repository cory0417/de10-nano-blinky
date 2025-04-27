#include <error.h>
#include <fcntl.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <unistd.h>
#include "hps_0.h"

#define HPS2FPGASLAVES 0xC0000000UL
#define BRIDGE_SPAN 0x6000UL

int main(int argc, char **argv)
{
    uint32_t delay_cycles = 0;
    uint32_t pulse_width_cycles = 0;
    uint32_t pulse_repetition = 0;

    void *start_map = NULL;
    void *delay_cycles_map = NULL;
    void *pulse_width_cycles_map = NULL;
    void *pulse_repetition_map = NULL;

    void *bridge_map = NULL;

    int fd = 0;
    int result = 0;

    if (argc != 4)
    {
        perror("Only 3 numbers should be passed.");
        return -1;
    }

    delay_cycles = strtoul(argv[1], NULL, 10);
    pulse_width_cycles = strtoul(argv[2], NULL, 10);
    pulse_repetition = strtoul(argv[3], NULL, 10);

    fd = open("/dev/mem", O_RDWR | O_SYNC);

    if (fd < 0)
    {
        perror("Couldn't open /dev/mem\n");
        return -2;
    }

    printf("Trying to map\n");
    bridge_map = mmap(NULL, BRIDGE_SPAN, PROT_READ | PROT_WRITE, MAP_SHARED, fd, HPS2FPGASLAVES);
    printf("Done mapping\n");
    if (bridge_map == MAP_FAILED)
    {
        perror("mmap failed.");
        return -3;
    }
    printf("Trying to write\n");
    start_map = bridge_map + (unsigned long)PULSE_START_PIO_BASE;
    delay_cycles_map = bridge_map + (unsigned long)PULSE_DELAY_PIO_BASE;
    pulse_width_cycles_map = bridge_map + (unsigned long)PULSE_WIDTH_PIO_BASE;
    pulse_repetition_map = bridge_map + (unsigned long)PULSE_REPETITION_PIO_BASE;
    *((volatile uint32_t *)start_map) = 0;
    *((volatile uint32_t *)delay_cycles_map) = delay_cycles;
    *((volatile uint32_t *)pulse_width_cycles_map) = pulse_width_cycles;
    *((volatile uint32_t *)pulse_repetition_map) = pulse_repetition;
    *((volatile uint32_t *)start_map) = 1;
    usleep(1);
    *((volatile uint32_t *)start_map) = 0;
    printf("Pulse generator started.\n");
    printf("Delay cycles: %d\n", delay_cycles);
    printf("Pulse width cycles: %d\n", pulse_width_cycles);
    printf("Pulse repetition: %d\n", pulse_repetition);
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