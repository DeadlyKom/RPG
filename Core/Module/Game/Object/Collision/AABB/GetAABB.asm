
                ifndef _MODULE_GAME_OBJECT_COLLISION_GET_AABB_
                define _MODULE_GAME_OBJECT_COLLISION_GET_AABB_
; -----------------------------------------
; получение AABB объекта
; In:
;   A  - тип объекта
;   C  - направление объекта
; Out:
; Corrupt:
;   C, AF
; Note:
; -----------------------------------------
GetObject:      ; переход в зависимости от типа объекта
                LD B, A
                AND IDX_OBJECT_TYPE
                ADD A, A
                LD (.Jump), A
                LD A, B
.Jump           EQU $+1
                JR $

                ; OBJECT_PLAYER
                JP PawnAABB                                                     ; объект имеет коллизию
                DB #00                                                          ; dummy
                ; OBJECT_NPC
                JP PawnAABB                                                     ; объект имеет коллизию
                DB #00                                                          ; dummy
                ; OBJECT_DECAL
                JP $                                                            ; объект не имеет коллизию
                DB #00                                                          ; dummy
                ; OBJECT_COLLISION
                JP DecalAABB                                                    ; объект имеет коллизию
                DB #00                                                          ; dummy
                ; OBJECT_PARTICLE
                JP $                                                            ; объект не имеет коллизию
                DB #00                                                          ; dummy
                ; 5
                JP $
                DB #00                                                          ; dummy
                ; 6
                JP $
                DB #00                                                          ; dummy
                ; 7
                JP $

                endif ; ~_MODULE_GAME_OBJECT_COLLISION_GET_AABB_