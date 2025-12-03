## Generated SDC file "SDDD4.out.sdc"

## Copyright (C) 2017  Intel Corporation. All rights reserved.
## Your use of Intel Corporation's design tools, logic functions 
## and other software and tools, and its AMPP partner logic 
## functions, and any output files from any of the foregoing 
## (including device programming or simulation files), and any 
## associated documentation or information are expressly subject 
## to the terms and conditions of the Intel Program License 
## Subscription Agreement, the Intel Quartus Prime License Agreement,
## the Intel FPGA IP License Agreement, or other applicable license
## agreement, including, without limitation, that your use is for
## the sole purpose of programming logic devices manufactured by
## Intel and sold by Intel or its authorized distributors.  Please
## refer to the applicable agreement for further details.


## VENDOR  "Altera"
## PROGRAM "Quartus Prime"
## VERSION "Version 17.1.0 Build 590 10/25/2017 SJ Lite Edition"

## DATE    "Wed Nov 12 08:50:51 2025"

##
## DEVICE  "5CSEMA5F31C6"
##


#**************************************************************
# Time Information
#**************************************************************

set_time_format -unit ns -decimal_places 3



#**************************************************************
# Create Clock
#**************************************************************

create_clock -name {altera_reserved_tck} -period 33.333 -waveform { 0.000 16.666 } [get_ports {altera_reserved_tck}]
create_clock -name {CLOCK_50} -period 20.000 -waveform { 0.000 10.000 } 


#**************************************************************
# Create Generated Clock
#**************************************************************



#**************************************************************
# Set Clock Latency
#**************************************************************



#**************************************************************
# Set Clock Uncertainty
#**************************************************************

set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}] -setup 0.310  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}] -hold 0.270  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}] -setup 0.310  
set_clock_uncertainty -rise_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}] -hold 0.270  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}] -setup 0.310  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -rise_to [get_clocks {altera_reserved_tck}] -hold 0.270  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}] -setup 0.310  
set_clock_uncertainty -fall_from [get_clocks {altera_reserved_tck}] -fall_to [get_clocks {altera_reserved_tck}] -hold 0.270  


#**************************************************************
# Set Input Delay
#**************************************************************



#**************************************************************
# Set Output Delay
#**************************************************************



#**************************************************************
# Set Clock Groups
#**************************************************************

set_clock_groups -asynchronous -group [get_clocks {altera_reserved_tck}] 


#**************************************************************
# Set False Path
#**************************************************************

set_false_path -from [get_registers {*|alt_jtag_atlantic:*|jupdate}] -to [get_registers {*|alt_jtag_atlantic:*|jupdate1*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|rdata[*]}] -to [get_registers {*|alt_jtag_atlantic*|td_shift[*]}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|read}] -to [get_registers {*|alt_jtag_atlantic:*|read1*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|read_req}] 
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|rvalid}] -to [get_registers {*|alt_jtag_atlantic*|td_shift[*]}]
set_false_path -from [get_registers {*|t_dav}] -to [get_registers {*|alt_jtag_atlantic:*|tck_t_dav}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|user_saw_rvalid}] -to [get_registers {*|alt_jtag_atlantic:*|rvalid0*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|wdata[*]}] -to [get_registers *]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|write}] -to [get_registers {*|alt_jtag_atlantic:*|write1*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|write_stalled}] -to [get_registers {*|alt_jtag_atlantic:*|t_ena*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|write_stalled}] -to [get_registers {*|alt_jtag_atlantic:*|t_pause*}]
set_false_path -from [get_registers {*|alt_jtag_atlantic:*|write_valid}] 
set_false_path -to [get_keepers {*altera_std_synchronizer:*|din_s1}]
set_false_path -from [get_keepers {altera_reserved_tdi}] -to [get_keepers {pzdyqx*}]
set_false_path -to [get_pins -nocase -compatibility_mode {*|alt_rst_sync_uq1|altera_reset_synchronizer_int_chain*|clrn}]
set_false_path -from [get_keepers {*nios_nios2_qsys:*|nios_nios2_qsys_nios2_oci:the_nios_nios2_qsys_nios2_oci|nios_nios2_qsys_nios2_oci_break:the_nios_nios2_qsys_nios2_oci_break|break_readreg*}] -to [get_keepers {*nios_nios2_qsys:*|nios_nios2_qsys_nios2_oci:the_nios_nios2_qsys_nios2_oci|nios_nios2_qsys_jtag_debug_module_wrapper:the_nios_nios2_qsys_jtag_debug_module_wrapper|nios_nios2_qsys_jtag_debug_module_tck:the_nios_nios2_qsys_jtag_debug_module_tck|*sr*}]
set_false_path -from [get_keepers {*nios_nios2_qsys:*|nios_nios2_qsys_nios2_oci:the_nios_nios2_qsys_nios2_oci|nios_nios2_qsys_nios2_oci_debug:the_nios_nios2_qsys_nios2_oci_debug|*resetlatch}] -to [get_keepers {*nios_nios2_qsys:*|nios_nios2_qsys_nios2_oci:the_nios_nios2_qsys_nios2_oci|nios_nios2_qsys_jtag_debug_module_wrapper:the_nios_nios2_qsys_jtag_debug_module_wrapper|nios_nios2_qsys_jtag_debug_module_tck:the_nios_nios2_qsys_jtag_debug_module_tck|*sr[33]}]
set_false_path -from [get_keepers {*nios_nios2_qsys:*|nios_nios2_qsys_nios2_oci:the_nios_nios2_qsys_nios2_oci|nios_nios2_qsys_nios2_oci_debug:the_nios_nios2_qsys_nios2_oci_debug|monitor_ready}] -to [get_keepers {*nios_nios2_qsys:*|nios_nios2_qsys_nios2_oci:the_nios_nios2_qsys_nios2_oci|nios_nios2_qsys_jtag_debug_module_wrapper:the_nios_nios2_qsys_jtag_debug_module_wrapper|nios_nios2_qsys_jtag_debug_module_tck:the_nios_nios2_qsys_jtag_debug_module_tck|*sr[0]}]
set_false_path -from [get_keepers {*nios_nios2_qsys:*|nios_nios2_qsys_nios2_oci:the_nios_nios2_qsys_nios2_oci|nios_nios2_qsys_nios2_oci_debug:the_nios_nios2_qsys_nios2_oci_debug|monitor_error}] -to [get_keepers {*nios_nios2_qsys:*|nios_nios2_qsys_nios2_oci:the_nios_nios2_qsys_nios2_oci|nios_nios2_qsys_jtag_debug_module_wrapper:the_nios_nios2_qsys_jtag_debug_module_wrapper|nios_nios2_qsys_jtag_debug_module_tck:the_nios_nios2_qsys_jtag_debug_module_tck|*sr[34]}]
set_false_path -from [get_keepers {*nios_nios2_qsys:*|nios_nios2_qsys_nios2_oci:the_nios_nios2_qsys_nios2_oci|nios_nios2_qsys_nios2_ocimem:the_nios_nios2_qsys_nios2_ocimem|*MonDReg*}] -to [get_keepers {*nios_nios2_qsys:*|nios_nios2_qsys_nios2_oci:the_nios_nios2_qsys_nios2_oci|nios_nios2_qsys_jtag_debug_module_wrapper:the_nios_nios2_qsys_jtag_debug_module_wrapper|nios_nios2_qsys_jtag_debug_module_tck:the_nios_nios2_qsys_jtag_debug_module_tck|*sr*}]
set_false_path -from [get_keepers {*nios_nios2_qsys:*|nios_nios2_qsys_nios2_oci:the_nios_nios2_qsys_nios2_oci|nios_nios2_qsys_jtag_debug_module_wrapper:the_nios_nios2_qsys_jtag_debug_module_wrapper|nios_nios2_qsys_jtag_debug_module_tck:the_nios_nios2_qsys_jtag_debug_module_tck|*sr*}] -to [get_keepers {*nios_nios2_qsys:*|nios_nios2_qsys_nios2_oci:the_nios_nios2_qsys_nios2_oci|nios_nios2_qsys_jtag_debug_module_wrapper:the_nios_nios2_qsys_jtag_debug_module_wrapper|nios_nios2_qsys_jtag_debug_module_sysclk:the_nios_nios2_qsys_jtag_debug_module_sysclk|*jdo*}]
set_false_path -from [get_keepers {sld_hub:*|irf_reg*}] -to [get_keepers {*nios_nios2_qsys:*|nios_nios2_qsys_nios2_oci:the_nios_nios2_qsys_nios2_oci|nios_nios2_qsys_jtag_debug_module_wrapper:the_nios_nios2_qsys_jtag_debug_module_wrapper|nios_nios2_qsys_jtag_debug_module_sysclk:the_nios_nios2_qsys_jtag_debug_module_sysclk|ir*}]
set_false_path -from [get_keepers {sld_hub:*|sld_shadow_jsm:shadow_jsm|state[1]}] -to [get_keepers {*nios_nios2_qsys:*|nios_nios2_qsys_nios2_oci:the_nios_nios2_qsys_nios2_oci|nios_nios2_qsys_nios2_oci_debug:the_nios_nios2_qsys_nios2_oci_debug|monitor_go}]


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
# Set Disable Timing
#**************************************************************

set_disable_timing -from * -to * [get_cells -hierarchical {QXXQ6833_0}]
set_disable_timing -from * -to * [get_cells -hierarchical {JEQQ5299_0}]
set_disable_timing -from * -to * [get_cells -hierarchical {JEQQ5299_1}]
set_disable_timing -from * -to * [get_cells -hierarchical {JEQQ5299_2}]
set_disable_timing -from * -to * [get_cells -hierarchical {JEQQ5299_3}]
set_disable_timing -from * -to * [get_cells -hierarchical {JEQQ5299_4}]
set_disable_timing -from * -to * [get_cells -hierarchical {JEQQ5299_5}]
set_disable_timing -from * -to * [get_cells -hierarchical {JEQQ5299_6}]
set_disable_timing -from * -to * [get_cells -hierarchical {JEQQ5299_7}]
set_disable_timing -from * -to * [get_cells -hierarchical {BITP7563_0}]
