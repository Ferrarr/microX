#include <microx/types.h>
#include <microx/16550.h>

static volatile unsigned char *uart = (volatile unsigned char *)UART0;

void uart_putc(char c)
{
	*uart = c;
}
