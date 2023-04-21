
                ifndef _CORE_MODULE_OBJECT_SPAWN_NPC_
                define _CORE_MODULE_OBJECT_SPAWN_NPC_
; -----------------------------------------
; спавн NPC в мире
; In:
;   DE - позиция игрока (D - y, E - x)
;   BC - параметры      (B - , C - тип объекта)
;   IY - адрес объекта FObject
; Out:
; Corrupt:
;   HL, DE, BC, AF, HL', DE', BC', AF', IY
; Note:
; -----------------------------------------
NPC:            ; -----------------------------------------
                ; инициализация
                ; -----------------------------------------
                SET VISIBLE_OBJECT_BIT, C
                LD (IY + FObject.Type), C                                       ; тип юнита

                ; установка позиции по горизонтали
                LD A, E
                LD E, #00
                rept 4
                ADD A, A
                RL E
                endr
                LD (IY + FObject.Position.X.Low), A
                LD (IY + FObject.Position.X.High), E
                
                ;  установка позиции по вертикали
                LD A, D
                LD D, #00
                rept 4
                ADD A, A
                RL D
                endr
                LD (IY + FObject.Position.Y.Low), A
                LD (IY + FObject.Position.Y.High), D

                XOR A

                ; сброс скорости
                LD (IY + FObject.EnginePower), A

                ; сброс направления
                LD (IY + FObject.Direction), A

                ; сброс скорости
                LD (IY + FObject.Velocity.X.Low), A
                LD (IY + FObject.Velocity.X.High), A
                LD (IY + FObject.Velocity.Y.Low), A
                LD (IY + FObject.Velocity.Y.High), A

                ; сброс счётчика
                LD (IY + FObject.VFX), #04

                RET

                display " - Spawn object 'NPC' in world:\t\t\t", /A, NPC, " = busy [ ", /D, $ - NPC, " bytes  ]"

                endif ; ~ _CORE_MODULE_OBJECT_SPAWN_NPC_
