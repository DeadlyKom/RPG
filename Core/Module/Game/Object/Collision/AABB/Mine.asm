
                ifndef _MODULE_GAME_OBJECT_COLLISION_GET_AABB_MINE_
                define _MODULE_GAME_OBJECT_COLLISION_GET_AABB_MINE_
; -----------------------------------------
; получение AABB мины
; In:
;   A  - тип объекта
;   C  - направление объекта
; Out:
;   DE - смещение AABB (D - y, E - x)
;   BC - размер AABB (B - y, C - x)
; Corrupt:
; Note:
; -----------------------------------------
MineAABB:       LD DE, ((2) & 0xFF) << 8 | ((2) & 0xFF)                         ; DE - смещение AABB (D - y, E - x)
                LD BC, #0505                                                    ; BC - размер AABB (B - y, C - x)
                RET

                endif ; ~_MODULE_GAME_OBJECT_COLLISION_GET_AABB_MINE_
