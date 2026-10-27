OUTPUT_ARCH(riscv:rv64)
ENTRY(_entry)

PHDRS
{
    text    PT_LOAD FLAGS(5);   /* PF_R | PF_X = 5 */
    rodata  PT_LOAD FLAGS(4);   /* PF_R = 4 */
    data    PT_LOAD FLAGS(6);   /* PF_R | PF_W = 6 */
    bss     PT_LOAD FLAGS(6);   /* PF_R | PF_W = 6 */
}

SECTIONS
{
    /* QEMU RAM starting point */
    . = 0x80000000;

    .text : {
        *(.text.entry)
        *(.text .text.*)
    } :text

    .rodata : {
        *(.rodata .rodata.*)
    } :rodata

    .data : {
        *(.data .data.*)
    } :data

    .bss : {
        __bss_start = .;
        *(.bss .bss.*)
        *(COMMON)
        __bss_end = .;
    } :bss

    . = ALIGN(16);
    . += 0x10000;   /* 64 KiB reserved for stack */
    __stack_top = .;
}
