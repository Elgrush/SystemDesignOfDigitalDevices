#define switches ((volatile int *) 0x0002010)
#define leds ((volatile int *) 0x0002000)
#define hex ((volatile int *) 0x0000000)
#define bitshuffler ((volatile int *) 0x0000004)

void main() {
	// LED example
	/*while (1) {
		*leds = *switches;
		*hex = *switches;
	}*/
	
	unsigned m, x, y, b;
	
	// Square root
	x = *switches;
	m = 0x40000000;
	y = 0;
	while (m != 0) {
		b = y | m;
		y >>= 1;
		if (x >= b) {
			x -= b;
			y |= m;
		}
		m >>= 2;
	}
	*leds = y;
	*hex = y;

	/*x = *switches;
	m = 3;
	y = 1;
	while (m != 0) {
		y *= x;
		m -= 1;
	}
	*leds = y;*/

	// Bit shuffle
	/* x = *switches;
	y = 0;
	y = (y << 1) | ((x & 0b00000001) ? 1 : 0);
	y = (y << 1) | ((x & 0b00000010) ? 1 : 0);
	y = (y << 1) | ((x & 0b00000100) ? 1 : 0);
	y = (y << 1) | ((x & 0b00001000) ? 1 : 0);
	y = (y << 1) | ((x & 0b00010000) ? 1 : 0);
	y = (y << 1) | ((x & 0b00100000) ? 1 : 0);
	y = (y << 1) | ((x & 0b01000000) ? 1 : 0);
	y = (y << 1) | ((x & 0b10000000) ? 1 : 0);
	*leds = y; */
	
	// HW-accelerated bit shuffle
	/*while (1) {
		*bitshuffler = *switches;
		*leds = *bitshuffler;
	}*/
}