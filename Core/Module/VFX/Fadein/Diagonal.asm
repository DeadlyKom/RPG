
                ifndef _CORE_MODULE_VFX_FADE_IN_DIAGONAL_
                define _CORE_MODULE_VFX_FADE_IN_DIAGONAL_
; -----------------------------------------
; осветление "диагональ"
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Diagonal_In:    ; инициализация переменных
                LD A, #1C
                LD (.pv1), A
                LD A, #03
                LD (.pv2), A

                SET_SCREEN_SHADOW                                               ; установка страницы теневого экрана

.Loop           HALT
.pv1            EQU $+1
                LD DE, #001C

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

                CALL .CopyChar

                INC D
                LD A, D
                CP 24
                JR NC, .exlp0
                DEC E
                JP P, .plp0
.exlp0
.pv2            EQU $+1
                LD DE, #1703

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

                CALL .CopyChar

                DEC D
                JP M, .exlp1
                INC E
                BIT 5,E
                JP Z, .plp1

.exlp1          LD A, (.pv2)
                INC A
                LD (.pv2), A

                LD A,(.pv1)
                DEC A
                LD (.pv1), A
	            JP P, .Loop

                RET

.CopyChar       ; -----------------------------------------

                ; копирование атрибута
                SET 7, H
                LD A, (HL)
                RES 7, H
                LD (HL), A

                ; преобразование в адрес пикселей
                LD A, H
                ADD A, A
                ADD A, A
                ADD A, A
                XOR H
                AND %00011111
                XOR H
                LD H, A

                ; копировани знакоместо
                dup 7
                SET 7, H
                LD A, (HL)
                RES 7, H
                LD (HL), A
                INC H
                edup
                SET 7, H
                LD A, (HL)
                RES 7, H
                LD (HL), A

                RET

                endif ; ~ _CORE_MODULE_VFX_FADE_IN_DIAGONAL_
