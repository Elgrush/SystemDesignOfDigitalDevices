# RISC-V puzyric
#

            .text

start:      
            lw      s4, 0(zero)
            addi    s4, s4, -1  # Кол-во циклов
            li      s1, 0
            li      s3, 1       # Начальная точка массива

main_cycle: 
            li      t0, -1
            sub     t0, s1, t0
            beqz    t0, set_zero
done_setting_zero:
            bnez    s1, skip_setup
            li      s1, 1       # Не выйти за левую грань
skip_setup:
            add     s2, s3, s1 # Адрес правого
            lw      s6,  0(s2)
            lw      s5, -1(s2)
            addi    a0, s5, 0
            addi    a1, s6, 0
right_lesser_then_left:
            sltu      a0, a1, a0
after_cpr:
            beqz    a0, end_of_iteration
            sw      s6, -1(s2)
            sw      s5,  0(s2)
            addi    s1, s1, -2
            sub     t0, s6, s5
            bnez    t0, end_of_iteration
            addi    s1, s1, -1
end_of_iteration:
            addi    s1, s1, 1
            sw      s1, 0(zero)
            sub     t0, s1, s4
            bnez    t0, main_cycle
            beqz    zero, out

set_zero:
    li s1, 0
    beqz zero, done_setting_zero

out:
            li      t0, -1
            sw      t0, 0(zero)

fi:
            beqz    zero, fi
            