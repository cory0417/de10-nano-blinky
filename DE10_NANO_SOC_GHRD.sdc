#**************************************************************
# This .sdc file is created by Terasic Tool.
# Users are recommended to modify this file to match users logic.
#**************************************************************

#**************************************************************
# Create Clock
#**************************************************************
create_clock -period "50.0 MHz" [get_ports FPGA_CLK1_50]
create_clock -period "50.0 MHz" [get_ports FPGA_CLK2_50]
create_clock -period "50.0 MHz" [get_ports FPGA_CLK3_50]

# for enhancing USB BlasterII to be reliable, 25MHz
create_clock -name {altera_reserved_tck} -period 40 {altera_reserved_tck}
set_input_delay -clock altera_reserved_tck -clock_fall 3 [get_ports altera_reserved_tdi]
set_input_delay -clock altera_reserved_tck -clock_fall 3 [get_ports altera_reserved_tms]
set_output_delay -clock altera_reserved_tck 3 [get_ports altera_reserved_tdo]

#**************************************************************
# Create Generated Clock
#**************************************************************
derive_pll_clocks



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************
derive_clock_uncertainty



#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************



#**************************************************************
# Set False Path
#**************************************************************



#**************************************************************
# Set Multicycle Path
#**************************************************************



#**************************************************************
# Set Maximum Delay
#**************************************************************



#**************************************************************
# Set Minimum Delay
#**************************************************************



#**************************************************************
# Set Input Transition
#**************************************************************



#**************************************************************
# Set Load
#**************************************************************

# JTAG Timing Constraints for DE10-Nano

# Set time format for better messages
set_time_format -unit ns -decimal_places 3

# USB Blaster II default clock ~24 MHz
# Period = ~41.666 ns
create_clock -name {altera_reserved_tck} -period 41.666 [get_ports {altera_reserved_tck}]
set_clock_groups -asynchronous -group {altera_reserved_tck}

# TDI/TMS/TDO delays are typically small inside DE10-Nano board, 
# because FPGA is very close to JTAG header.

# Set maximum input delays relative to TCK (based on conservative USB Blaster specs)
# (TMS input delay)
set_input_delay -clock altera_reserved_tck -max 20.0 [get_ports {altera_reserved_tms}]
set_input_delay -clock altera_reserved_tck -min  5.0 [get_ports {altera_reserved_tms}]
# (TDI input delay)
set_input_delay -clock altera_reserved_tck -max 20.0 [get_ports {altera_reserved_tdi}]
set_input_delay -clock altera_reserved_tck -min  5.0 [get_ports {altera_reserved_tdi}]

# Set maximum output delay relative to TCK (for TDO)
set_output_delay -clock altera_reserved_tck -max 20.0 [get_ports {altera_reserved_tdo}]
set_output_delay -clock altera_reserved_tck -min  5.0 [get_ports {altera_reserved_tdo}]

# Cut false paths between unrelated ports
set_false_path -from [get_ports {altera_reserved_tdi}] -to [get_ports {altera_reserved_tdo}]