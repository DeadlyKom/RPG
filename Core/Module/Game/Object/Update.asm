
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
                JP NPC.Update
                DB #00                                                          ; dummy
                ; 2
                JP Decal
                DB #00                                                          ; dummy
                ; 3
                JP Decal
                DB #00                                                          ; dummy
                ; 4
                JP Particle
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

                rept 4
                SRA H
                RR L
                endr

                LD DE, (IX + FObject.Position.X)
                ADD HL, DE
                LD (IX + FObject.Position.X), HL

                LD HL, (IX + FObject.Velocity.Y)

                rept 4
                SRA H
                RR L
                endr
                
                LD DE, (IX + FObject.Position.Y)
                ADD HL, DE
                LD (IX + FObject.Position.Y), HL


                ; if (x > y)
                ; {
                ;   // угол от 0° до 45°
                ;   if (x * 0.5 > y)
                ;   {
                ;     // угол до 0° до ~26.5°
                ;     if(x * 0.25 > y)
                ;     {
                ;       // угол до 0° до ~14.04°        (0.0 - 0.25)
                ;     }
                ;     else
                ;     {
                ;       // угол до ~14.04° до ~26.5°    (0.25 - 0.5)
                ;     }
                ;   }
                ;   else 
                ;   {
                ;     // угол от ~26.5° до 45°
                ;     if(x * 0.5 > y * 0.5)
                ;     {
                ;       // угол до ~26.5° до ~36.87°    (0.5 - 0.75)
                ;     }
                ;     else
                ;     {
                ;       // угол до ~36.87° до 45°       (0.75 - 1.0)
                ;     }
                ;   }
                ; }
                ; else
                ; {
                ;   // угол от 45° до 90°
                ;   if (y * 0.5 > x)
                ;   {
                ;     // угол от ~63.44° до 90°
                ;     if(y * 0.25 > x)
                ;     {
                ;       // угол до ~75.96° до 90°       (4.0 - ...)
                ;     }
                ;     else
                ;     {
                ;       // угол до ~63.44° до ~75.96°   (2.0 - 4.0)
                ;     }
                ;   }
                ;   else
                ;   {
                ;     // угол от 45° до ~63.44°
                ;     if(y * 0.25 > x * 0.5)
                ;     {
                ;       // угол до ~56.3° до ~63.44°    (1.5 - 2.0)
                ;     }
                ;     else
                ;     {
                ;       // угол до 45° до ~56.3°        (1.0 - 1.5)
                ;     }
                ;   }
                ; }
 
.RET            RET

                endif ; ~_MODULE_GAME_OBJECT_UPDATE_
