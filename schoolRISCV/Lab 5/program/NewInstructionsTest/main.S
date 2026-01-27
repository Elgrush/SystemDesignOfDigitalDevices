# RISC-V simple counter program
#
# Stanislav Zhelnio, 2020
#

            .text

start:      li  a0, 1
            li  a1, 5
            srli a1, a1, 1
            mul  a0, a1, a0
            jalr a2, a0, -2
