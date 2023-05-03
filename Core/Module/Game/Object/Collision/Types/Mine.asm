
                ifndef _MODULE_GAME_OBJECT_COLLISION_TYPES_MINE_
                define _MODULE_GAME_OBJECT_COLLISION_TYPES_MINE_
; -----------------------------------------
; обработка коллизии статического объекта с 
; In:
;   BC - дельта расстояния знаковое (B - y, C - x)
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Mine:           ; ToDo не учитывается тип динамического объекта
                PUSH IX

                ; -----------------------------------------
                ; статический
                ; -----------------------------------------
                LD IX, (Collision.StaticObject)

                ; проверка что мина взведена
                LD A, (IX + FObjectInteraction.Lifetime)
                CP LIFETIME_MINE - DELAY_ACTIVATE_MINE
                JR NC, .RET
                
                ; уничтожение объекта
                CALL Object.Remove

                ; спавн взрыва
                CALL Object.Spawn_Explosion

                ; -----------------------------------------
                ; динамический
                ; -----------------------------------------
                LD IX, (Collision.DynamicObject)   

                ; меняем вектор скорости по горизонтали 
                LD HL, (IX + FObject.Velocity.X)
                LD D, H
                LD E, L
                SRA D
                RR E
                OR A
                SBC HL, DE
                LD (IX + FObject.Velocity.X), HL

                ; меняем вектор скорости по вертикали 
                LD HL, (IX + FObject.Velocity.Y)
                LD D, H
                LD E, L
                SRA D
                RR E
                OR A
                SBC HL, DE
                LD (IX + FObject.Velocity.Y), HL

                ; ; уменьшить мощность в двое
                ; SRA (IX + FObject.EnginePower)
                ; ; SRA (IX + FObject.EnginePower)

                CALL Func.ApplyExplosion

.RET            POP IX
                
                RET

                endif ; ~_MODULE_GAME_OBJECT_COLLISION_TYPES_MINE_
