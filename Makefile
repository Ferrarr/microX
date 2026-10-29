.DEFAULT_GOAL := qemu

# ------------ BUILDING CONFIGS -------------- #
ARCH ?= riscv
ARCH := $(strip $(shell echo "$(ARCH)" | tr '[:upper:]' '[:lower:]'))
ARCH_DIR := arch/$(ARCH)

CPUS ?= 4

OBJS ?= build/$(ARCH)

SOURCE_DIRS := $(ARCH_DIR) drivers init libc
C_SOURCES := $(sort $(shell find $(SOURCE_DIRS) -type f -name '*.c' -print))
ASM_SOURCES := $(sort $(shell find $(SOURCE_DIRS) -type f -name '*.s' -print))

OBJECTS := $(patsubst %.c, $(OBJS)/%.o, $(C_SOURCES)) \
	   $(patsubst %.s, $(OBJS)/%.o, $(ASM_SOURCES))

# ------------	COMPILER FLAGS	-------------- #
INCLUDES := -Iinclude -Ilibc/include
CFLAGS := -std=gnu11 -O2 -g -Wall -Wextra \
	  -ffreestanding -fno-builtin -fno-stack-protector \
	  -D__is_libk
ASFLAGS := -O2 -g -Wall -Wextra

# ------------	  ARCH FLAGS	-------------- #
include $(ARCH_DIR)/Makefile

ifeq ($(origin CC),default)
  ifneq ($(CROSS_COMPILE),)
    CC := $(CROSS_COMPILE)gcc
  else
    CC := riscv64-linux-gnu-gcc
  endif
endif

ARCH_LDSCRIPT := $(ARCH_DIR)/linker.ld

# ------------	   TARGETS	-------------- #
DEPS := $(OBJECTS:.o=.d)
MICROX := $(OBJS)/vmmicrox
MAP := $(OBJS)/vmmicrox.map
GDB ?= $(if $(CROSS_COMPILE),$(CROSS_COMPILE)gdb,riscv64-linux-gnu-gdb)
GDB_PORT ?= 1234

SOURCE_SUBDIRS := $(sort $(shell find $(SOURCE_DIRS) -type d -print))

.PHONY: all clean qemu qemu-debug gdb

all: $(MICROX)

qemu: $(MICROX)
	$(QEMU) $(QEMUFLAGS) -kernel "$(MICROX)"

qemu-debug: $(MICROX)
	$(QEMU) $(QEMUFLAGS) \
		-gdb tcp::$(GDB_PORT) -S \
		-no-reboot -no-shutdown \
		-kernel "$(MICROX)"

gdb: $(MICROX)
	$(GDB) -ex "target remote :$(GDB_PORT)" "$(MICROX)"

$(OBJS)/%.o: %.c Makefile $(ARCH_DIR)/Makefile
	@mkdir -p $(@D)
	$(CC) $(CFLAGS) $(INCLUDES) $(ARCH_CFLAGS) \
		-MMD -MP -c $< -o $@

$(OBJS)/%.o: %.s Makefile $(ARCH_DIR)/Makefile
	@mkdir -p $(@D)
	$(CC) $(ASFLAGS) $(INCLUDES) $(ARCH_CFLAGS) \
		-MMD -MP -c $< -o $@

$(MICROX): $(OBJECTS) $(SOURCE_SUBDIRS) $(ARCH_LDSCRIPT) Makefile $(ARCH_DIR)/Makefile
	@mkdir -p $(@D)
	$(CC) $(ARCH_LDFLAGS) -nostdlib -static \
		-Wl,-T,$(ARCH_LDSCRIPT) \
		-Wl,-Map,$(MAP) \
		-o $@ $(OBJECTS)

-include $(DEPS)

clean:
	rm -rf $(OBJS)
