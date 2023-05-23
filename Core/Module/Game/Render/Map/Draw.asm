
                ifndef _MODULE_GAME_RENDER_MAP_DRAW_
                define _MODULE_GAME_RENDER_MAP_DRAW_
; -----------------------------------------
; отображение карты
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Draw:           ; счётчик отображаемого экрана
                LD HL, .Counter
                LD A, (HL)
                INC (HL)
                RRA
                JR NC, .BaseDraw

.ShadowDraw     CALL Func.ShadowScrcpy                                          ; копирования в теневой экран
                JP .Processed
                
.BaseDraw       SetPort PAGE_6, 1                                               ; включить 6 страницу и показать теневой экран

                ; проверка флага первичной инициализации
                CHECK_MENU_FLAG MENU_STARTUP_BIT
                JR Z, .NotStartup
                RES_FLAG MENU_STARTUP_BIT                                       ; сброс флага первичной инициализации

                ; -----------------------------------------
                ; первичная инициализация
                ; -----------------------------------------

.NotStartup     ; проверка флага обновления
                CHECK_MENU_FLAG MENU_UPDTAE_BIT
                JR Z, .Draw
                RES_FLAG MENU_UPDTAE_BIT                                        ; сброс флага первичной инициализации
                
                ; -----------------------------------------
                ; обновление
                ; -----------------------------------------
                ; отображение рамок

                CALL DisplayMapFrame

.Draw           ; -----------------------------------------
                ; основной цикл рисования
                ; -----------------------------------------

.Processed      ifdef _DEBUG
                CALL FPS_Counter.Frame
                endif

                ; ifdef _DEBUG
                ; LD DE, #0100
                ; CALL Console.SetCursor
                ; LD A, (GameState.CursorID)
                ; CALL Console.DrawByte
                ; LD A, (PlayerState.SettlementLocID)
                ; CALL Console.DrawByte
                ; endif

                SET_RENDER_FLAG FINISHED_BIT                                    ; установка флага завершения отрисовки
                RET

.Counter        DB #00

                endif ; ~_MODULE_GAME_RENDER_MAP_DRAW_
