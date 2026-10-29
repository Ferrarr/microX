.section .text.entry
.globl _entry

_entry:
    la		sp,	__stack_top
    mv		s0,	a0
    mv		s1,	a1
    call	main

1:
    j     1b
