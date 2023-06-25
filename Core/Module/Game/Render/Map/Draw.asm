
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

.ShadowDraw     CALL Func.ShadowScrcpy                                          ; копирование в теневой экран
                JP .Processed
                
.BaseDraw       SetPort PAGE_6, 1                                               ; включить 6 страницу и показать теневой экран

                ; проверка флага первичной инициализации
                CHECK_MENU_FLAG MENU_STARTUP_BIT
                JR Z, .NotStartup
                RES_FLAG MENU_STARTUP_BIT                                       ; сброс флага первичной инициализации

                ; -----------------------------------------
                ; первичная инициализация
                ; -----------------------------------------

                ; отображение рамок
                CALL DisplayMapFrame

.NotStartup     ; проверка флага обновления
                CHECK_MENU_FLAG MENU_UPDTAE_BIT
                JR Z, .Draw
                RES_FLAG MENU_UPDTAE_BIT                                        ; сброс флага первичной инициализации
                
                ; -----------------------------------------
                ; обновление
                ; -----------------------------------------

                ; отображение регионов
                CALL DisplayRegion

                ;
                SET_SCREEN_BASE                                                 ; включение страницы основного экрана
                CLS_RECT #4000, SCR_MAP_POS_X, SCR_MAP_POS_Y, SCR_MAP_SIZE_X, SCR_MAP_SIZE_Y

.Draw           ; -----------------------------------------
                ; основной цикл рисования
                ; -----------------------------------------
                ; отображение маркеров
                CALL DisplayMarker

.Processed      ifdef _DEBUG
                CALL FPS_Counter.Frame
                endif

                ifdef _DEBUG
                LD DE, #0119
                CALL Console.SetCursor
                LD A, (PlayerState.MapPosX)
                CALL Console.DrawByte
                LD A, (PlayerState.MapPosY)
                CALL Console.DrawByte
                endif

                SET_RENDER_FLAG FINISHED_BIT                                    ; установка флага завершения отрисовки
                RET

.Counter        DB #00

                endif ; ~_MODULE_GAME_RENDER_MAP_DRAW_
