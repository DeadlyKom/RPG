
                ifndef _MODULE_GAME_RENDER_WASTELAND_PREPARE_
                define _MODULE_GAME_RENDER_WASTELAND_PREPARE_
; -----------------------------------------
; подготовка пустоши
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Prepare:        ; сохранение текущего счётчика
                LD HL, (TickCounterRef)
                LD (.OldTickCounter), HL

                ; генерация спрайтов для пустоши
                CALL Execute.WastelandSpr

                SET_PAGE_OBJECT                                                 ; включить страницу работы с объектами
                CALL Packs.OpenWorld.Wasteland.Generate

                ;
                CALL Packs.OpenWorld.Wasteland.Initialize
                
                ; копирования в базовый экран
                CALL Func.BaseScrcpy

                ; отображение UI пустоши
                CALL UI_Draw

                ; отобразить в теневом экране пустошь
                CALL Draw
                RES_RENDER_FLAG FINISHED_BIT                                    ; сброс флага завершения отрисовки, для эффекта

                ; подсчёт пройденых прерываний
.OldTickCounter EQU $+1
                LD DE, #0000
                LD HL, (TickCounterRef)
                OR A
                SBC HL, DE

                LD A, #28
                SUB L
                RET M

                ; ожидание
                INC A
                LD B, A
.Wait           HALT
                DJNZ .Wait

                RET

                endif ; ~_MODULE_GAME_RENDER_WASTELAND_PREPARE_
