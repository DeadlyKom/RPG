
                ifndef _CORE_MODULE_OPEN_WORLD_OBJECT_COLLISION_TYPES_DECAL_
                define _CORE_MODULE_OPEN_WORLD_OBJECT_COLLISION_TYPES_DECAL_
; -----------------------------------------
; обработка коллизии статического объекта с 
; In:
;   BC - дельта расстояния знаковое (B - y, C - x)
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Decal:          ; ToDo не учитывается тип динамического объекта
                PUSH IX

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

                ; уменьшить мощность в двое
                SRA (IX + FObject.EnginePower)
                ; SRA (IX + FObject.EnginePower)

                ; -----------------------------------------
                ; статический
                ; -----------------------------------------
                LD IX, (Collision.StaticObject)
                CALL Packs.OpenWorld.Object.Utils.Remove

                POP IX
                
                RET

                endif ; ~_CORE_MODULE_OPEN_WORLD_OBJECT_COLLISION_TYPES_DECAL_
