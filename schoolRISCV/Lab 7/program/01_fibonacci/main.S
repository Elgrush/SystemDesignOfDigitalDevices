# RISC-V fibonacci program
#
# Stanislav Zhelnio, 2020
#

            .text

start:      mv    t0, zero
            li    t1, 1
            mv    a0, t1
            mv    a2, zero #0000067F
            lw    a2, 1(zero)
            slli  a2, a2, 24
            srli  a2, a2, 24
fibonacci:  add   t0, t0, t1
            mv    a0, t0
            add   t1, t0, t1
            mv    a0, t1
            addi  a2, a2, -1
            beqz  a2,  out
            beqz  zero fibonacci
out:        mv t1, a0 #0005107F
            