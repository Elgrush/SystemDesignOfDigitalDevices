set_global_assignment -entity "audio_nios" -library "lib_audio_nios" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "audio_nios" -library "lib_audio_nios" -name IP_TOOL_VERSION "17.1"
set_global_assignment -entity "audio_nios" -library "lib_audio_nios" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_audio_nios" -name SPD_FILE [file join $::quartus(sip_path) "../audio_nios.spd"]
set_global_assignment -library "lib_audio_nios" -name MISC_FILE [file join $::quartus(sip_path) "../../audio_nios.qsys"]

set_global_assignment -library "lib_audio_nios" -name MISC_FILE [file join $::quartus(sip_path) "audio_nios.v"]
set_global_assignment -library "lib_audio_nios" -name MISC_FILE [file join $::quartus(sip_path) "submodules/audio_nios_altpll_audio.vo"]
