
                ifndef _CORE_MODULE_OPEN_WORLD_OBJECT_COLLISION_GET_AABB_PAWN_
                define _CORE_MODULE_OPEN_WORLD_OBJECT_COLLISION_GET_AABB_PAWN_
; -----------------------------------------
; получение AABB пешки
; In:
;   A  - тип объекта
;   C  - направление объекта
; Out:
;   DE - смещение AABB (D - y, E - x)
;   BC - размер AABB (B - y, C - x)
; Corrupt:
; Note:
; -----------------------------------------
PawnAABB:       ; -----------------------------------------
                ;   A  - тип объекта
                ;   C  - направление объекта
                ; Out:
                ;   HL - адрес информации о спрайте FSprite
                ; -----------------------------------------
                CALL Object.GetSpriteInfo

                LD A, (HL)                                                      ; FSprite.Info.Height
                INC HL
                LD D, (HL)                                                      ; FSprite.Info.OffsetY
                SRL A
                LD B, A
                INC HL
                LD A, (HL)                                                      ; FSprite.Info.Width
                INC HL
                LD E, (HL)                                                      ; FSprite.Info.OffsetX
                SRL A
                LD C, A

                RET

                endif ; ~_CORE_MODULE_OPEN_WORLD_OBJECT_COLLISION_GET_AABB_PAWN_
