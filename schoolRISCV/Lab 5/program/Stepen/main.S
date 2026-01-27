# RISC-V simple counter program
#
# Stanislav Zhelnio, 2020
#

            .text

start:      li  a0, 6
            mv  a1, a0
            li  a2, 5
            addi a2, a2, -1
do:         addi a2, a2, -1
            mul  a0, a1, a0
            bne  zero, a2, do
