
                ifndef _MODULE_GAME_RENDER_SETTLEMENT_DRAW_
                define _MODULE_GAME_RENDER_SETTLEMENT_DRAW_
; -----------------------------------------
; отображение поселение
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

                ; проверка флага первичной инициализации
                CHECK_MENU_FLAG MENU_STARTUP_BIT
                JR Z, .NotStartup
                RES_FLAG MENU_STARTUP_BIT                                       ; сброс флага первичной инициализации

                LD A, CHAR_STATE_NONE
                LD (GameState.CharacterState), A

                LD A, (PlayerState.CharacterID)
                LD (GameState.CharacterID), A

.NotStartup     SET_PAGE_OBJECT                                                 ; включить страницу работы с объектами 
                ; расчёт адреса поселения в котором находится игрок
                LD A, (PlayerState.SettlementID)
                CALL Packs.OpenWorld.Utils.CalcSettlement

                ; проверка флага обновления
                CHECK_MENU_FLAG MENU_UPDTAE_BIT
                JR Z, .Draw
                RES_FLAG MENU_UPDTAE_BIT                                        ; сброс флага первичной инициализации
                
                ; отображение место нахождения игрока
                CALL DisplayLoc

                ; отображение рамок
                CALL DisplayFrame
                CALL DisplayArtFrame

.Draw           ; обновление секущего внутреигрового времни
                CALL DisplayTime

                ; отображение персонажа
                CALL DisplayChar

                ; отображение доступных построек в поселении
                CALL DisplayBuildLst

.Processed      ifdef _DEBUG
                CALL FPS_Counter.Frame
                endif

                SET_RENDER_FLAG FINISHED_BIT                                    ; установка флага завершения отрисовки
                RET

.Counter        DB #00

                endif ; ~_MODULE_GAME_RENDER_SETTLEMENT_DRAW_
