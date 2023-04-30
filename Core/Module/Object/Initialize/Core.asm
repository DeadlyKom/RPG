
                ifndef _CORE_MODULE_OBJECT_CORE_
                define _CORE_MODULE_OBJECT_CORE_
Begin           EQU $
; -----------------------------------------
; спавн частицы в мире
; In:
;   DE - смещение частицы   (D - y, E - x)
;   IX - адрес объекта копирования позиции FObject
;   IY - адрес объекта FObject
; Out:
; Corrupt:
;   HL, DE, BC, AF
; Note:
; -----------------------------------------
CalcPosition:   ; установка позиции по горизонтали
                LD HL, (IX + FObject.Position.X)
                RL E
                SBC A, A
                LD B, A
                LD A, E
                LD E, C
                rept 3
                ADD A, A
                RL B
                endr
                LD C, A
                ADD HL, BC
                LD (IY + FObject.Position.X), HL
                
                ;  установка позиции по вертикали
                LD HL, (IX + FObject.Position.Y)
                RL D
                SBC A, A
                LD B, A
                LD A, D
                rept 3
                ADD A, A
                RL B
                endr
                LD C, A
                ADD HL, BC
                LD (IY + FObject.Position.Y), HL

                RET

                display " - Initialize core:\t\t\t\t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endif ; ~ _CORE_MODULE_OBJECT_CORE_
