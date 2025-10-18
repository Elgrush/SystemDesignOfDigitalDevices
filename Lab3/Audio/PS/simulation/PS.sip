set_global_assignment -entity "PS" -library "lib_PS" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "PS" -library "lib_PS" -name IP_TOOL_VERSION "17.1"
set_global_assignment -entity "PS" -library "lib_PS" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_PS" -name SPD_FILE [file join $::quartus(sip_path) "../PS.spd"]
set_global_assignment -library "lib_PS" -name MISC_FILE [file join $::quartus(sip_path) "../../PS.qsys"]

set_global_assignment -library "lib_PS" -name MISC_FILE [file join $::quartus(sip_path) "PS.v"]
set_global_assignment -library "lib_PS" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_up_ps2.v"]
set_global_assignment -library "lib_PS" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_up_ps2_command_out.v"]
set_global_assignment -library "lib_PS" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_up_ps2_data_in.v"]
set_global_assignment -library "lib_PS" -name MISC_FILE [file join $::quartus(sip_path) "submodules/PS_ps2_0.v"]
