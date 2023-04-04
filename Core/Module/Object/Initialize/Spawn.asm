
                ifndef _CORE_MODULE_OBJECT_SPAWN_
                define _CORE_MODULE_OBJECT_SPAWN_
; -----------------------------------------
; спавн объекта в мире
; In:
;   DE - позиция юнита  (D - y, E - x)
;   BC - параметры      (B - , C - тип юнита)
; Out:
;   IX - адрес юнита
; Corrupt:
;   HL, DE, BC, AF, HL', DE', BC', AF', IX
; Note:
; -----------------------------------------
Spawn:          ; поиск свободной ячейки
                EXX

                ; инициализация
                LD HL, Adr.Object
                LD DE, OBJECT_SIZE - 1
                LD BC, OBJECTS_NUM + 1                                          ; количество элементов
                LD A, OBJECT_EMPTY_ELEMENT

                ; поиск свободной ячейки 
.Loop           CPI
                JR Z, .Spawn
                ADD HL, DE
                JP PE, .Loop
                RET

.Spawn          ; адрес свободного элемента найден
                DEC HL
                PUSH HL
                POP IX

                ; увеличение количества юнитов в массиве
                LD HL, GameState.Objects
                LD E, (HL)
                LD A, OBJECTS_NUM
                SUB C
                RET C                                                           ; выход если нет место в массиве

                INC (HL)
                EXX

                ; -----------------------------------------
                ; инициализация
                ; -----------------------------------------
                
                LD (IX + FObject.Type), C                                       ; тип юнита

                ; установка позиции по горизонтали
                LD A, E
                LD E, #00
                rept 4
                ADD A, A
                RL E
                endr
                LD (IX + FObject.Position.X.Low), A
                LD (IX + FObject.Position.X.High), E
                
                ;  установка позиции по вертикали
                LD A, D
                LD D, #00
                rept 4
                ADD A, A
                RL D
                endr
                LD (IX + FObject.Position.Y.Low), A
                LD (IX + FObject.Position.Y.High), D

                XOR A

                ; сброс направления
                LD (IX + FObject.Direction), A

                ; сброс скорости
                LD (IX + FObject.Velocity.X.Low), A
                LD (IX + FObject.Velocity.X.High), A
                LD (IX + FObject.Velocity.Y.Low), A
                LD (IX + FObject.Velocity.Y.High), A

                RET

                display " - Spawn object in world : \t\t\t\t", /A, Spawn, " = busy [ ", /D, $ - Spawn, " bytes  ]"

                endif ; ~ _CORE_MODULE_OBJECT_SPAWN_
