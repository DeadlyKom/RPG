
                ifndef _MODULE_GAME_OBJECT_COLLISION_GET_AABB_PAWN_
                define _MODULE_GAME_OBJECT_COLLISION_GET_AABB_PAWN_
; -----------------------------------------
; получение AABB пешки
; In:
;   A  - тип объекта
;   C  - направление объекта
; Out:
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
                SUB (HL)                                                        ; FSprite.Info.OffsetY
                SRL A
                LD B, A
                INC HL
                LD A, (HL)                                                      ; FSprite.Info.Width
                INC HL
                SUB (HL)                                                        ; FSprite.Info.OffsetX
                SRL A
                LD C, A

                RET

                endif ; ~_MODULE_GAME_OBJECT_COLLISION_GET_AABB_PAWN_
