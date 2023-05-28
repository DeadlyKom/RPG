
                ifndef _CORE_MODULE_OPEN_WORLD_UTILS_ROTATE_LEFT_x32_
                define _CORE_MODULE_OPEN_WORLD_UTILS_ROTATE_LEFT_x32_
; -----------------------------------------
; прокрутить 32-битное значение влево
; In:
;   DEHL - 32-битное значение
;   B    - количество раз
; Out:
;   DEHL - прокрученое 32-битное значение N-раз
; Corrupt:
; Note:
; -----------------------------------------
RotateLeft:     
.Loop           LD A, D
                ADD A, A
                RL L
                RL H
                RL E
                RL D
                DJNZ .Loop

                RET

                endif ; ~ _CORE_MODULE_OPEN_WORLD_UTILS_ROTATE_LEFT_x32_
