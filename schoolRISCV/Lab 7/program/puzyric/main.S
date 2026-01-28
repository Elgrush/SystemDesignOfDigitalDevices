# RISC-V puzyric
#

            .text

start:      
            lw      s4, 0(zero)
            addi    s4, s4, -1  # Кол-во циклов
            li      s1, 0
            li      s3, 1       # Начальная точка массива

main_cycle: 
            bnez    s1, skip_setup
            li      s1, 1       # Не выйти за левую грань
skip_setup:
            add     s2, s3, s1 # Адрес правого
            lw      s5,  0(s2)
            lw      s6, -1(s2)
            addi    a1, s5, 0
            addi    a0, s6, 0
            beqz    zero, right_lesser_then_left
after_cpr:
            beqz    a0, end_of_iteration
            sw      s5, -1(s2)
            sw      s6,  0(s2)
end_of_iteration:
            addi    s1, s1, 1
            sub     t0, s1, s4
            beqz    t0, out
            beqz    zero, main_cycle

right_lesser_then_left:
            beqz     a1, right_lesser_no
            beqz     a0, right_lesser_yes
            srli     a1, a1, 1
            srli     a0, a0, 1
            beqz     zero, after_cpr
right_lesser_yes:
            li      a0, 1
            beqz    zero, after_cpr
right_lesser_no:
            li      a0, 0
            beqz    zero, after_cpr

out:
            li      t0, 1
            sw      t0, 0(zero)
            