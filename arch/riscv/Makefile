# ------------	 QEMU CONFIGS	-------------- #
CROSS_COMPILE ?= riscv64-linux-gnu-

ARCH_CFLAGS += -march=rv64imac -mabi=lp64 -mcmodel=medany
ARCH_LDFLAGS += -march=rv64imac -mabi=lp64 -mcmodel=medany

QEMU ?= qemu-system-riscv64
QEMUFLAGS ?= -machine virt \
             -m 256M \
             -smp $(CPUS) \
             -bios default \
             -display none \
             -serial stdio \
             -monitor none
