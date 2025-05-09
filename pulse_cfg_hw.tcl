# TCL File Generated by Component Editor 24.1
# Thu Apr 24 01:40:06 EDT 2025
# DO NOT MODIFY


# 
# pulse_cfg "pulse_cfg" v1.0
#  2025.04.24.01:40:06
# 
# 

# 
# request TCL package from ACDS 16.1
# 
package require -exact qsys 16.1


# 
# module pulse_cfg
# 
set_module_property DESCRIPTION ""
set_module_property NAME pulse_cfg
set_module_property VERSION 1.0
set_module_property INTERNAL false
set_module_property OPAQUE_ADDRESS_MAP true
set_module_property AUTHOR ""
set_module_property DISPLAY_NAME pulse_cfg
set_module_property INSTANTIATE_IN_SYSTEM_MODULE true
set_module_property EDITABLE true
set_module_property REPORT_TO_TALKBACK false
set_module_property ALLOW_GREYBOX_GENERATION false
set_module_property REPORT_HIERARCHY false


# 
# file sets
# 
add_fileset QUARTUS_SYNTH QUARTUS_SYNTH "" ""
set_fileset_property QUARTUS_SYNTH TOP_LEVEL pulse_cfg
set_fileset_property QUARTUS_SYNTH ENABLE_RELATIVE_INCLUDE_PATHS false
set_fileset_property QUARTUS_SYNTH ENABLE_FILE_OVERWRITE_MODE false
add_fileset_file pulse_cfg.sv SYSTEM_VERILOG PATH ip/pulse_cfg/pulse_cfg.sv TOP_LEVEL_FILE


# 
# parameters
# 
add_parameter N INTEGER 4
set_parameter_property N DEFAULT_VALUE 4
set_parameter_property N DISPLAY_NAME N
set_parameter_property N TYPE INTEGER
set_parameter_property N UNITS None
set_parameter_property N ALLOWED_RANGES -2147483648:2147483647
set_parameter_property N HDL_PARAMETER true
add_parameter DW INTEGER 32
set_parameter_property DW DEFAULT_VALUE 32
set_parameter_property DW DISPLAY_NAME DW
set_parameter_property DW TYPE INTEGER
set_parameter_property DW UNITS None
set_parameter_property DW ALLOWED_RANGES -2147483648:2147483647
set_parameter_property DW HDL_PARAMETER true
add_parameter AW INTEGER 3
set_parameter_property AW DEFAULT_VALUE 3
set_parameter_property AW DISPLAY_NAME AW
set_parameter_property AW TYPE INTEGER
set_parameter_property AW UNITS None
set_parameter_property AW ALLOWED_RANGES -2147483648:2147483647
set_parameter_property AW HDL_PARAMETER true


# 
# display items
# 


# 
# connection point clock
# 
add_interface clock clock end
set_interface_property clock clockRate 0
set_interface_property clock ENABLED true
set_interface_property clock EXPORT_OF ""
set_interface_property clock PORT_NAME_MAP ""
set_interface_property clock CMSIS_SVD_VARIABLES ""
set_interface_property clock SVD_ADDRESS_GROUP ""

add_interface_port clock clk clk Input 1


# 
# connection point reset
# 
add_interface reset reset end
set_interface_property reset associatedClock clock
set_interface_property reset synchronousEdges DEASSERT
set_interface_property reset ENABLED true
set_interface_property reset EXPORT_OF ""
set_interface_property reset PORT_NAME_MAP ""
set_interface_property reset CMSIS_SVD_VARIABLES ""
set_interface_property reset SVD_ADDRESS_GROUP ""

add_interface_port reset reset_n reset_n Input 1


# 
# connection point avalon_slave_0
# 
add_interface avalon_slave_0 avalon end
set_interface_property avalon_slave_0 addressUnits WORDS
set_interface_property avalon_slave_0 associatedClock clock
set_interface_property avalon_slave_0 associatedReset reset
set_interface_property avalon_slave_0 bitsPerSymbol 8
set_interface_property avalon_slave_0 burstOnBurstBoundariesOnly false
set_interface_property avalon_slave_0 burstcountUnits WORDS
set_interface_property avalon_slave_0 explicitAddressSpan 0
set_interface_property avalon_slave_0 holdTime 0
set_interface_property avalon_slave_0 linewrapBursts false
set_interface_property avalon_slave_0 maximumPendingReadTransactions 1
set_interface_property avalon_slave_0 maximumPendingWriteTransactions 1
set_interface_property avalon_slave_0 readLatency 0
set_interface_property avalon_slave_0 readWaitTime 1
set_interface_property avalon_slave_0 setupTime 0
set_interface_property avalon_slave_0 timingUnits Cycles
set_interface_property avalon_slave_0 writeWaitTime 0
set_interface_property avalon_slave_0 ENABLED true
set_interface_property avalon_slave_0 EXPORT_OF ""
set_interface_property avalon_slave_0 PORT_NAME_MAP ""
set_interface_property avalon_slave_0 CMSIS_SVD_VARIABLES ""
set_interface_property avalon_slave_0 SVD_ADDRESS_GROUP ""

add_interface_port avalon_slave_0 avs_chipselect chipselect Input 1
add_interface_port avalon_slave_0 avs_read read Input 1
add_interface_port avalon_slave_0 avs_write write Input 1
add_interface_port avalon_slave_0 avs_address address Input "((AW-1)) - (0) + 1"
add_interface_port avalon_slave_0 avs_writedata writedata Input "((DW-1)) - (0) + 1"
add_interface_port avalon_slave_0 avs_readdata readdata Output "((DW-1)) - (0) + 1"
add_interface_port avalon_slave_0 avs_waitrequest waitrequest Output 1
add_interface_port avalon_slave_0 avs_readdatavalid readdatavalid Output 1
add_interface_port avalon_slave_0 avs_response response Output 2
add_interface_port avalon_slave_0 avs_writeresponsevalid writeresponsevalid Output 1
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isFlash 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isMemoryDevice 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isNonVolatileStorage 0
set_interface_assignment avalon_slave_0 embeddedsw.configuration.isPrintableDevice 0


# 
# connection point delay_bus
# 
add_interface delay_bus conduit end
set_interface_property delay_bus associatedClock ""
set_interface_property delay_bus associatedReset ""
set_interface_property delay_bus ENABLED true
set_interface_property delay_bus EXPORT_OF ""
set_interface_property delay_bus PORT_NAME_MAP ""
set_interface_property delay_bus CMSIS_SVD_VARIABLES ""
set_interface_property delay_bus SVD_ADDRESS_GROUP ""

add_interface_port delay_bus delay_bus delay_bus Output "((N*DW)-1) - (0) + 1"


# 
# connection point width_bus
# 
add_interface width_bus conduit end
set_interface_property width_bus associatedClock ""
set_interface_property width_bus associatedReset ""
set_interface_property width_bus ENABLED true
set_interface_property width_bus EXPORT_OF ""
set_interface_property width_bus PORT_NAME_MAP ""
set_interface_property width_bus CMSIS_SVD_VARIABLES ""
set_interface_property width_bus SVD_ADDRESS_GROUP ""

add_interface_port width_bus width_bus width_bus Output "((N*DW)-1) - (0) + 1"

