#ifndef _MICROX_16550_H
#define _MICROX_16550_H

// QEMU places UART at address 0x1000_0000
#define UART0 0x10000000

// simple putc and print function for now
void uart_putc(char);
void print(const char *);

#endif // _MICROX_16550_H
