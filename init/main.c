#include <microx/types.h>
#include <microx/16550.h>
#include <stdio.h>

/* 
 * OpenSBI guarantees when we reach only 1 hart is active
 * initialize devices based on the device tree
*/

int main(uint64 hartid, uint64 dtb_pointer)
{
	printf("Hello from RISC-V!\n");

	// print checks
	printf("hartid: %ld\n", hartid);
	printf("dtb_pointer: %ld\n", dtb_pointer);

	while (1) {
	}

	return 0;
}
