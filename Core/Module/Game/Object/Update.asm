
                ifndef _MODULE_GAME_OBJECT_UPDATE_
                define _MODULE_GAME_OBJECT_UPDATE_
; -----------------------------------------
; обновление объектов
; In:
;   IX - адрес обрабатываемого объекта FObject
; Out:
; Corrupt:
; Note:
; ----------------------------------------
Update:         ; добавить точку выхода обновления объекта
                LD HL, .RET
                PUSH HL

                ; переход в зависимости от типа объекта
                LD A, (IX + FObject.Type)                                       ; получим тип объекта
                AND IDX_OBJECT_TYPE
                ADD A, A
                LD (.Jump), A
.Jump           EQU $+1
                JR $

                ; 0
                JP PlayerObject
                DB #00                                                          ; dummy
                ; 1
                RET
                DB #00, #00, #00                                                ; dummy
                ; 2
                RET
                DB #00, #00, #00                                                ; dummy
                ; 3
                RET
                DB #00, #00, #00                                                ; dummy
                ; 4
                RET
                DB #00, #00, #00                                                ; dummy
                ; 5
                RET
                DB #00, #00, #00                                                ; dummy
                ; 6
                RET
                DB #00, #00, #00                                                ; dummy
                ; 7
                RET

.RET            ; ----------------------------------------
                ; общая логика поведения для всех объектов
                ; ----------------------------------------

                ; расчитать новую позицию объекта, учитывая его скорость
                LD HL, (IX + FObject.Velocity.X)
                LD DE, (IX + FObject.Position.X)
                ADD HL, DE
                LD (IX + FObject.Position.X), HL

                LD HL, (IX + FObject.Velocity.Y)
                LD DE, (IX + FObject.Position.Y)
                ADD HL, DE
                LD (IX + FObject.Position.Y), HL


                ; if (x > y)
                ; {
                ;   // угол от 0 до 45
                ;   if (0.5*x > y)
                ;   {
                ;     // угол до 0 до 26.5
                ;   }
                ;   else 
                ;   {
                ;     // угол от 26.5 до 45
                ;   }
                ; }
                ; else
                ; {
                ;   // угол от 45 до 90
                ;   if (0.5*y > x)
                ;   {
                ;     // угол от 63.5 до 90
                ;   }
                ;   else
                ;   {
                ;     // угол от 45 до 63.5
                ;   }
                ; }

                RET

                endif ; ~_MODULE_GAME_OBJECT_UPDATE_
