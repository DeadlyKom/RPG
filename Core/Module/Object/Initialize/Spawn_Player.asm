
                ifndef _CORE_MODULE_OBJECT_SPAWN_PLAYER_
                define _CORE_MODULE_OBJECT_SPAWN_PLAYER_
; -----------------------------------------
; спавн объекта в мире
; In:
;   DE - позиция юнита  (D - y, E - x)
;   BC - параметры      (B - , C - тип объекта)
;   IX - адрес объекта
; Out:
; Corrupt:
;   HL, DE, BC, AF, HL', DE', BC', AF', IX
; Note:
; -----------------------------------------
Player:         ; -----------------------------------------
                ; инициализация
                ; -----------------------------------------
                SET VISIBLE_OBJECT_BIT, C                                       ; принудительно включить флаг видимости
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

                display " - Spawn object 'PLAYER' in world : \t\t\t", /A, Player, " = busy [ ", /D, $ - Player, " bytes  ]"

                endif ; ~ _CORE_MODULE_OBJECT_SPAWN_PLAYER_
