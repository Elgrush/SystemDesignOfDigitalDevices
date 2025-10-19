/*
 * mouse.c
 *
 *  Created on: 19 окт. 2025 г.
 *      Author: Elgrush
 */

#include "mouse.h"

int mouse_innit(alt_up_ps2_dev* ps2) {
	ps2 = alt_up_ps2_open_dev("ps2_0");
	return ps2 == NULL;
}

void ps2_read (alt_up_ps2_dev* ps2, unsigned char* control_byte, unsigned char* X, unsigned char* Y) {
	alt_up_ps2_clear_fifo(ps2);
	alt_up_ps2_read_data_byte_timeout(ps2, control_byte);
	alt_up_ps2_read_data_byte_timeout(ps2, X);
	alt_up_ps2_read_data_byte_timeout(ps2, Y);
}
