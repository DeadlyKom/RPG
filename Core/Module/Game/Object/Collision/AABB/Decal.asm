
                ifndef _MODULE_GAME_OBJECT_COLLISION_GET_AABB_DECAL_
                define _MODULE_GAME_OBJECT_COLLISION_GET_AABB_DECAL_
; -----------------------------------------
; получение AABB декали
; In:
;   A  - тип объекта
;   C  - направление объекта
; Out:
;   DE - смещение AABB (D - y, E - x)
;   BC - размер AABB (B - y, C - x)
; Corrupt:
; Note:
; -----------------------------------------
DecalAABB:      LD DE, ((10) & 0xFF) << 8 | ((4) & 0xFF)
                LD BC, #0304
                RET

                endif ; ~_MODULE_GAME_OBJECT_COLLISION_GET_AABB_DECAL_
