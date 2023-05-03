
                ifndef _CORE_MODULE_OBJECT_SPAWN_PLAYER_
                define _CORE_MODULE_OBJECT_SPAWN_PLAYER_
; -----------------------------------------
; спавн игрока в мире
; In:
;   DE - позиция игрока (D - y, E - x)
;   BC - параметры      (B - , C - )
;   IY - адрес объекта FObject
; Out:
; Corrupt:
;   HL, DE, BC, AF, HL', DE', BC', AF', IY
; Note:
; -----------------------------------------
Player:         ; -----------------------------------------
                ; инициализация
                ; -----------------------------------------
                LD (IY + FObject.Type), PLAYER_FACTION | OBJECT_PLAYER | VISIBLE_OBJECT                 ; тип юнита
                LD (IY + FObject.Flags), FLAG_NOT_DECAL | FLAG_DYNAMIC_OBJECT | FLAG_COLLISION_OBJECT   ; установка флагов

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

                ; установка характеристик персонажа
                LD (IY + FObject.Character.Health), #FF

                XOR A

                ; сброс скорости
                LD (IY + FObject.EnginePower), A

                ; сброс направления
                LD (IY + FObject.Direction), A
                LD (IY + FObject.MuzzleFlash), A

                ; сброс состояний
                LD (IY + FObject.State), A

                ; сброс скорости
                LD (IY + FObject.Velocity.X.Low), A
                LD (IY + FObject.Velocity.X.High), A
                LD (IY + FObject.Velocity.Y.Low), A
                LD (IY + FObject.Velocity.Y.High), A

                ; сброс счётчика
                LD (IY + FObject.VFX), #04

                OR A                                                            ; успешный спавн
                RET

                display " - Spawn object 'PLAYER' in world:\t\t\t", /A, Player, " = busy [ ", /D, $ - Player, " bytes  ]"

                endif ; ~ _CORE_MODULE_OBJECT_SPAWN_PLAYER_
