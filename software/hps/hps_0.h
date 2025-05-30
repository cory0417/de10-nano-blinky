#ifndef _ALTERA_HPS_0_H_
#define _ALTERA_HPS_0_H_

/*
 * This file was automatically generated by the swinfo2header utility.
 * 
 * Created from SOPC Builder system 'soc_system' in
 * file 'soc_system.sopcinfo'.
 */

/*
 * This file contains macros for module 'hps_0' and devices
 * connected to the following master:
 *   h2f_axi_master
 * 
 * Do not include this header file and another header file created for a
 * different module or master group at the same time.
 * Doing so may result in duplicate macro names.
 * Instead, use the system header file which has macros with unique names.
 */

/*
 * Macros for device 'pulse_width_pio', class 'altera_avalon_pio'
 * The macros are prefixed with 'PULSE_WIDTH_PIO_'.
 * The prefix is the slave descriptor.
 */
#define PULSE_WIDTH_PIO_COMPONENT_TYPE altera_avalon_pio
#define PULSE_WIDTH_PIO_COMPONENT_NAME pulse_width_pio
#define PULSE_WIDTH_PIO_BASE 0x0
#define PULSE_WIDTH_PIO_SPAN 16
#define PULSE_WIDTH_PIO_END 0xf
#define PULSE_WIDTH_PIO_BIT_CLEARING_EDGE_REGISTER 0
#define PULSE_WIDTH_PIO_BIT_MODIFYING_OUTPUT_REGISTER 0
#define PULSE_WIDTH_PIO_CAPTURE 0
#define PULSE_WIDTH_PIO_DATA_WIDTH 32
#define PULSE_WIDTH_PIO_DO_TEST_BENCH_WIRING 0
#define PULSE_WIDTH_PIO_DRIVEN_SIM_VALUE 0
#define PULSE_WIDTH_PIO_EDGE_TYPE NONE
#define PULSE_WIDTH_PIO_FREQ 50000000
#define PULSE_WIDTH_PIO_HAS_IN 0
#define PULSE_WIDTH_PIO_HAS_OUT 1
#define PULSE_WIDTH_PIO_HAS_TRI 0
#define PULSE_WIDTH_PIO_IRQ_TYPE NONE
#define PULSE_WIDTH_PIO_RESET_VALUE 0

/*
 * Macros for device 'pulse_delay_pio', class 'altera_avalon_pio'
 * The macros are prefixed with 'PULSE_DELAY_PIO_'.
 * The prefix is the slave descriptor.
 */
#define PULSE_DELAY_PIO_COMPONENT_TYPE altera_avalon_pio
#define PULSE_DELAY_PIO_COMPONENT_NAME pulse_delay_pio
#define PULSE_DELAY_PIO_BASE 0x10
#define PULSE_DELAY_PIO_SPAN 16
#define PULSE_DELAY_PIO_END 0x1f
#define PULSE_DELAY_PIO_BIT_CLEARING_EDGE_REGISTER 0
#define PULSE_DELAY_PIO_BIT_MODIFYING_OUTPUT_REGISTER 0
#define PULSE_DELAY_PIO_CAPTURE 0
#define PULSE_DELAY_PIO_DATA_WIDTH 32
#define PULSE_DELAY_PIO_DO_TEST_BENCH_WIRING 0
#define PULSE_DELAY_PIO_DRIVEN_SIM_VALUE 0
#define PULSE_DELAY_PIO_EDGE_TYPE NONE
#define PULSE_DELAY_PIO_FREQ 50000000
#define PULSE_DELAY_PIO_HAS_IN 0
#define PULSE_DELAY_PIO_HAS_OUT 1
#define PULSE_DELAY_PIO_HAS_TRI 0
#define PULSE_DELAY_PIO_IRQ_TYPE NONE
#define PULSE_DELAY_PIO_RESET_VALUE 0

/*
 * Macros for device 'pulse_start_pio', class 'altera_avalon_pio'
 * The macros are prefixed with 'PULSE_START_PIO_'.
 * The prefix is the slave descriptor.
 */
#define PULSE_START_PIO_COMPONENT_TYPE altera_avalon_pio
#define PULSE_START_PIO_COMPONENT_NAME pulse_start_pio
#define PULSE_START_PIO_BASE 0x20
#define PULSE_START_PIO_SPAN 16
#define PULSE_START_PIO_END 0x2f
#define PULSE_START_PIO_BIT_CLEARING_EDGE_REGISTER 0
#define PULSE_START_PIO_BIT_MODIFYING_OUTPUT_REGISTER 0
#define PULSE_START_PIO_CAPTURE 0
#define PULSE_START_PIO_DATA_WIDTH 1
#define PULSE_START_PIO_DO_TEST_BENCH_WIRING 0
#define PULSE_START_PIO_DRIVEN_SIM_VALUE 0
#define PULSE_START_PIO_EDGE_TYPE NONE
#define PULSE_START_PIO_FREQ 50000000
#define PULSE_START_PIO_HAS_IN 0
#define PULSE_START_PIO_HAS_OUT 1
#define PULSE_START_PIO_HAS_TRI 0
#define PULSE_START_PIO_IRQ_TYPE NONE
#define PULSE_START_PIO_RESET_VALUE 0

/*
 * Macros for device 'pulse_repetition_pio', class 'altera_avalon_pio'
 * The macros are prefixed with 'PULSE_REPETITION_PIO_'.
 * The prefix is the slave descriptor.
 */
#define PULSE_REPETITION_PIO_COMPONENT_TYPE altera_avalon_pio
#define PULSE_REPETITION_PIO_COMPONENT_NAME pulse_repetition_pio
#define PULSE_REPETITION_PIO_BASE 0x30
#define PULSE_REPETITION_PIO_SPAN 16
#define PULSE_REPETITION_PIO_END 0x3f
#define PULSE_REPETITION_PIO_BIT_CLEARING_EDGE_REGISTER 0
#define PULSE_REPETITION_PIO_BIT_MODIFYING_OUTPUT_REGISTER 0
#define PULSE_REPETITION_PIO_CAPTURE 0
#define PULSE_REPETITION_PIO_DATA_WIDTH 32
#define PULSE_REPETITION_PIO_DO_TEST_BENCH_WIRING 0
#define PULSE_REPETITION_PIO_DRIVEN_SIM_VALUE 0
#define PULSE_REPETITION_PIO_EDGE_TYPE NONE
#define PULSE_REPETITION_PIO_FREQ 50000000
#define PULSE_REPETITION_PIO_HAS_IN 0
#define PULSE_REPETITION_PIO_HAS_OUT 1
#define PULSE_REPETITION_PIO_HAS_TRI 0
#define PULSE_REPETITION_PIO_IRQ_TYPE NONE
#define PULSE_REPETITION_PIO_RESET_VALUE 0


#endif /* _ALTERA_HPS_0_H_ */
