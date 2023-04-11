
                ifndef _CORE_MODULE_DRAW_OBJECT_DRAW_
                define _CORE_MODULE_DRAW_OBJECT_DRAW_
; -----------------------------------------
; отображение спрайта объекта без атрибутов
; In:
;   IX - указывает на структуру FObject
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Draw:           ; переход в зависимости от типа объекта
                LD A, (IX + FObject.Type)                                       ; получим тип объекта
                AND IDX_OBJECT_TYPE
                ADD A, A
                LD (.Jump), A
.Jump           EQU $+1
                JR $

                ; 0
                JP DrawPlayer
                DB #00                                                          ; dummy
                ; 1
                JP DrawDecal
                DB #00                                                          ; dummy
                ; 2
                JP $
                DB #00                                                          ; dummy
                ; 3
                JP $
                DB #00                                                          ; dummy
                ; 4
                JP $
                DB #00                                                          ; dummy
                ; 5
                JP $
                DB #00                                                          ; dummy
                ; 6
                JP $
                DB #00                                                          ; dummy
                ; 7
                JP $

                display " - Draw object: \t\t\t\t\t", /A, Draw, " = busy [ ", /D, $ - Draw, " bytes  ]"

                endif ; ~ _CORE_MODULE_DRAW_OBJECT_DRAW_
