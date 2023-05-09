
                ifndef _MODULE_GAME_RENDER_MAIN_MENU_DRAW_
                define _MODULE_GAME_RENDER_MAIN_MENU_DRAW_
; -----------------------------------------
; отображение меню
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

.ShadowDraw     SetPort PAGE_7, 0                                               ; включить 7 страницу и показать основной экран
                LD HL, MemBank_01_SCR
                LD DE, MemBank_03_SCR
                LD BC, ScreenSize
                CALL Memcpy.FastLDIR
                JR .Processed
                
.BaseDraw       SetPort PAGE_6, 1                                               ; включить 6 страницу и показать теневой экран
                
                ; проверка бита затемнения
                CHECK_MENU_FLAG MENU_FADEOUT_BIT
                JP NZ, Fadeout

                ; какое меню отображаем?
                LD A, (GameState.MenuID)
                CP MENU_ID_MAIN
                CALL Z, Main
                CP MENU_ID_START
                CALL Z, StartGame
                CP MENU_ID_CONTINUE
                CALL Z, Continue
                CP MENU_ID_OPTIONS
                CALL Z, Options
                CP MENU_ID_REDEFINE
                CALL Z, RedefineKeys

.Processed      ifdef _DEBUG
                CALL FPS_Counter.Frame
                endif

                SET_RENDER_FLAG FINISHED_BIT                                    ; установка флага завершения отрисовки
                RET

.Counter        DB #00

                endif ; ~_MODULE_GAME_RENDER_MAIN_MENU_DRAW_