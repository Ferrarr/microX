#include <microx/types.h>
#include <asm/asm.h>

int main(void);

/* initialize minimal RISCV flags
 *
 *
 */
void start()
{
	uint64 mstatus = r_mstatus();

	// MPP = 3 -> Machine mode
	mstatus &= ~(3UL << 11);
	mstatus |= (3UL << 11);
	w_mstatus(mstatus);

	// mret to main in init/main.c
	w_mepc((uint64)main);
	asm volatile("mret");
}
