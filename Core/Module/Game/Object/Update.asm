
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
Update:         ; переход в зависимости от типа объекта
                LD A, (IX + FObject.Type)                                       ; получим тип объекта
                AND IDX_OBJECT_TYPE
                ADD A, A
                LD (.Jump), A
.Jump           EQU $+1
                JR $

                ; 0
                JP Player.Update
                DB #00                                                          ; dummy
                ; 1
                JP .RET
                DB #00                                                          ; dummy
                ; 2
                JP .RET
                DB #00                                                          ; dummy
                ; 3
                JP .RET
                DB #00                                                          ; dummy
                ; 4
                JP .RET
                DB #00                                                          ; dummy
                ; 5
                JP .RET
                DB #00                                                          ; dummy
                ; 6
                JP .RET
                DB #00                                                          ; dummy
                ; 7
                JP .RET

.Velocity       ; ----------------------------------------
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
 
.RET            RET

                endif ; ~_MODULE_GAME_OBJECT_UPDATE_
