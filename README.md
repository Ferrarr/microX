# microX Operating System

## Table of Contents
>
- [Introduction](##Introduction)
- [Timeline](##Timeline)
- [Features](##Features)
- [Credits](#credits)

---

## Introduction

microX is a re-implementation of xv6 which is a re-implementation of UNIX v6. While taking my Operating Systems course in University I found it quite difficult to follow the xv6-riscv project structure. After the course my curiosity just kept bugging me so I ended up doing a bunch of _research_ on OS (specifically Linux) and how it achieves portability - as in supporting multiple architecture.

So this project is really just a lesson on portability, hardware standards, and alike, the OS aspect is simply there for me to have fun and play around with. I'm planning to only support RISCV though from now, maybe after I'm happy with the state will I add support for ARM.

---

## Timeline

October 27, 2026: Initial commit, successfully printed "Hello from QEMU RISCV" through UART.
<br>
October 29, 2026: Removed manual RISC-V initialization, using OpenSBI instead. Added libc based on [osdev](https://wiki.osdev.org)'s [meaty skeleton](https://wiki.osdev.org/Meaty_Skeleton)

---

## Features

TBA

## Credits

- [osdev wiki](https://wiki.osdev.org)
