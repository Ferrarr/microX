#ifndef _RISCV_ASM_ASM_H
#define _RISCV_ASM_ASM_H

static inline void w_mepc(uint64 x)
{
	asm volatile("csrw mepc, %0" : : "r"(x));
}

static inline uint64 r_mstatus(void)
{
	uint64 x;
	asm volatile("csrr %0, mstatus" : "=r"(x));
	return x;
}

static inline void w_mstatus(uint64 x)
{
	asm volatile("csrw mstatus, %0" : : "r"(x));
}

#endif // _RISCV_ASM_ASM_H
