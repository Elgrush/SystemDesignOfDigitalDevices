/*
 * mouse.h
 *
 *  Created on: 19 окт. 2025 г.
 *      Author: Elgrush
 */

#ifndef MOUSE_H_
#define MOUSE_H_

int mouse_innit(alt_up_ps2_dev* ps2);

void ps2_read (alt_up_ps2_dev* ps2, unsigned char* control_byte, unsigned char* X, unsigned char* Y);

#endif /* MOUSE_H_ */
