
                ifndef _CORE_MODULE_OPEN_WORLD_OBJECT_INITIALIZE_CORE_
                define _CORE_MODULE_OPEN_WORLD_OBJECT_INITIALIZE_CORE_
Begin           EQU $
; -----------------------------------------
; приведение к мировой впозиции
; In:
;   DE - смещение частицы   (D - y, E - x)
;   IX - адрес объекта копирования позиции FObject
; Out:
;   HL - новая позиция по вертикали
;   DE - новая позиция по горизонтали
; Corrupt:
;   HL, DE, BC, AF
; Note:
; -----------------------------------------
WorldPosition:   ; установка позиции по горизонтали
                LD HL, (IX + FObject.Position.X)
                RL E
                SBC A, A
                LD B, A
                LD A, E
                rept 3
                ADD A, A
                RL B
                endr
                LD C, A
                ADD HL, BC
                PUSH HL
                
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
                POP DE

                RET

                display " - Initialize core:\t\t\t\t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endif ; ~ _CORE_MODULE_OPEN_WORLD_OBJECT_INITIALIZE_CORE_
