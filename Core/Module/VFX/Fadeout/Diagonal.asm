
                ifndef _CORE_MODULE_VFX_FADE_OUT_DIAGONAL_
                define _CORE_MODULE_VFX_FADE_OUT_DIAGONAL_
; -----------------------------------------
; уход в затемнение "диагональ"
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Diagonal_Out:   ; инициализация переменных
                XOR A
                LD (.pv1), A
                LD A, #1F
                LD (.pv2), A

                SHOW_BASE_SCREEN                                                ; отобразить основной экран

.Loop           HALT
.pv1            EQU $+1
                LD DE, #0000

.plp0           LD L, D
                LD H, #00
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                LD C, E
                LD B, #58
                ADD HL, BC
                LD (HL), #00
                INC D
                LD A, D
                CP 24
                JR NC, .exlp0
                DEC E
                JP P, .plp0
.exlp0
.pv2            EQU $+1
                LD DE, #171F

.plp1:          LD L, D
                LD H, #00
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                LD C, E
                LD B, #58
                ADD HL, BC
                LD (HL), #00
                DEC D
                JP M, .exlp1
                INC E
                BIT 5,E
                JP Z, .plp1

.exlp1          LD A, (.pv2)
                DEC A
                LD (.pv2), A

                LD A,(.pv1)
                INC A
                LD (.pv1), A
	            CP 32-4
	            JP NZ, .Loop

                RET

                endif ; ~ _CORE_MODULE_VFX_FADE_OUT_DIAGONAL_
