                ifndef _CORE_MODULE_DRAW_WORLD_ARROW_PREPARE_
                define _CORE_MODULE_DRAW_WORLD_ARROW_PREPARE_
; -----------------------------------------
; подготовка отрисовка стрелки (направление ближайшего врага)
; In:
;   DE - дельта расстояния знаковое (D - y, E - x)
; Out:
;   HL - позиция по горизонтали (12.4)
;   DE - позиция по вертикали (12.4)
;   A' - номер фрейма [0..15]
; Corrupt:
; Note:
; -----------------------------------------
Prepare:        PUSH DE

                ; -----------------------------------------
                ; In:
                ;   DE - дельта значений знаковое число (D - y, E - x)
                ; Out :
                ;   A  - номер сектора [0..15] << 3
                ; -----------------------------------------
                CALL Math.Atan
                EX AF, AF'

                XOR A
                LD (.X), A
                LD (.Y), A

                POP BC

                XOR A
                rept 3
                SRA B
                RRA
                endr
                LD D, B
                LD E, A

                LD HL, #0680
                OR A
                SBC HL, DE
                JP M, .L1

                LD A, H
                CP #02
                JR NC, .L2
.L1             LD HL, #0180
                LD A, #FF
                LD (.Y), A
                JR .LL1
.L2             CP #0A
                JR C, .LL1
                LD HL, #0A80
                LD A, #FF
                LD (.Y), A

.LL1            EX DE, HL

                XOR A
                rept 3
                SRA C
                RRA
                endr
                LD H, C
                LD L, A

                LD BC, #08C0
                OR A
                ADC HL, BC
                JP P, .L4
                LD HL, #0300
                LD A, #FF
                LD (.X), A
                JR .Exit

.L4             LD A, H
                CP #03
                JR NC, .L5
                LD HL, #0300
                LD A, #FF
                LD (.X), A
                JR .Exit
.L5             CP #0C
                JR C, .Exit
                LD HL, #0C80
                LD A, #FF
                LD (.X), A

.Exit           

.Y              EQU $+1
                LD A, #00
.X              EQU $+1
                OR #00
                ADD A, A
                RET

                endif ; ~ _CORE_MODULE_DRAW_WORLD_ARROW_PREPARE_
