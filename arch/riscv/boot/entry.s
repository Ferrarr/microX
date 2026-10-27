.section .text.entry
.globl _entry

_entry:
    csrr	t0,	mhartid
    bnez	t0,	spin

    la		sp,	__stack_top
    call	start

spin:
    j		spin
