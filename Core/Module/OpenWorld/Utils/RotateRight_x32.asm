
                ifndef _CORE_MODULE_OPEN_WORLD_UTILS_ROTATE_RIGHT_x32_
                define _CORE_MODULE_OPEN_WORLD_UTILS_ROTATE_RIGHT_x32_
; -----------------------------------------
; прокрутить 32-битное значение вправо
; In:
;   DEHL - 32-битное значение
;   B    - количество раз
; Out:
;   DEHL - прокрученое 32-битное значение N-раз
; Corrupt:
; Note:
; -----------------------------------------
RotateRight:    
.Loop           LD A, L
                RRA
                RR D
                RR E
                RR H
                RR L
                DJNZ .Loop

                RET

                endif ; ~ _CORE_MODULE_OPEN_WORLD_UTILS_ROTATE_RIGHT_x32_
