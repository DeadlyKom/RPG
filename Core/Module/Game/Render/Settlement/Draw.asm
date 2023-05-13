
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
                JP .Processed
                
.BaseDraw       SetPort PAGE_6, 1                                               ; включить 6 страницу и показать теневой экран
                
                ; обновление положения локальной ID
                CALL CalcCursorID
                
                SET_PAGE_OBJECT                                                 ; включить страницу работы с объектами
                
                ; расчёт адреса поселения в котором находится игрок
                LD A, (PlayerState.SettlementID)
                CALL Packs.OpenWorld.Utils.CalcSettlement

                ; проверка флага первичной инициализации
                CHECK_MENU_FLAG MENU_STARTUP_BIT
                JR Z, .NotStartup
                RES_FLAG MENU_STARTUP_BIT                                       ; сброс флага первичной инициализации

                ; -----------------------------------------
                ; первичная инициализация
                ; -----------------------------------------

                ; подсчёт количество бит в байте
                LD A, (IX + FSettlement.Building)
                LD BC, #0800                                                    ; +1 т.к. 1 дополнительная опция "выход в пустош"
                                                                                ; -1 т.к. не отображается опция в которой находимся
.CalcBits       ADD A, A
                JR NC, $+3
                INC C
                DJNZ .CalcBits

                ; инициализация курсора
                LD HL, GameState.Cursor
                LD (HL), #00                                                    ; текущая позиция
                INC L
                LD (HL), C                                                      ; количество позиций
                INC L
                LD (HL), #FF                                                    ; предыдущая позиция
                INC L
                LD (HL), #00                                                    ; верхняя граница
                INC L
                LD (HL), (LIST_HEIGHT * 8) / HEIGHT_ROW                         ; доступная высота (вкл)
                INC L
                LD (HL), (COLUMN_BUILD * 8) - 8                                 ; положение по горизонтали
                INC L
                LD (HL), ROW_BUILD * 8                                          ; положение по вертикали
                INC L
                LD (HL), #00                                                    ; направление

                ; позиция курсора
                LD A, #00
                LD (GameState.CursorID+0), A
                LD (GameState.CursorID+1), A
                LD (GameState.CursorID+2), A

                ; ToDo тестовые настройки
                LD A, CHAR_STATE_NONE
                LD (GameState.CharacterState), A

                LD A, (PlayerState.CharacterID)
                LD (GameState.CharacterID), A

                LD A, #00
                LD (PlayerState.SettlementLocID), A

.NotStartup     ; проверка флага обновления
                CHECK_MENU_FLAG MENU_UPDTAE_BIT
                JR Z, .NotUpdateMenu
                RES_FLAG MENU_UPDTAE_BIT                                        ; сброс флага первичной инициализации
                
                ; отображение место нахождения игрока
                CALL ClearLoc
                CALL DisplayLoc

                ; отображение рамок
                CALL DisplayFrame
                CALL DisplayArtFrame

                ; отображение доступных построек в поселении
                CALL ClearBuildList
                CALL DisplayBuildLst

.NotUpdateMenu  ; проверка флага обновление скрола
                CHECK_MENU_FLAG MENU_UPDATE_SCROLL_BIT
                JR Z, .Draw
                RES_FLAG MENU_UPDATE_SCROLL_BIT                                 ; сброс флага обновление скрола

                ; отображение скрола
                CALL ClearScroll
                CALL DisplayScroll

.Draw           ; обновление секущего внутреигрового времни
                CALL DisplayTime

                ; отображение персонажа
                CALL DisplayChar

                ; отображение курсора
                CALL Cursor.Draw

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

; -----------------------------------------
; очистка блока
; In:
;   HL - адрес экрана
;   BC - размер блока (B - ширина, C - высота)
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ClearBlock      INC C
                LD D, B
.RowLoop        LD E, L
                XOR A
                LD B, D

.Loop           LD (HL), A
                INC L
                DJNZ .Loop

                LD L, E

                ; классический метод "DOWN HL" 25/59
                INC H
                LD A, H
                AND #07
                JP NZ, $+12
                LD A, L
                SUB #E0
                LD L, A
                SBC A, A
                AND #F8
                ADD A, H
                LD H, A

                DEC C
                JR NZ, .RowLoop

                RET

CalcCursorID:   ; расчёт текущее положение курсора
                LD A, (GameState.CursorID+1)
                LD C, A
                LD HL, GameState.Cursor
                LD A, (HL)
                INC L
                INC L
                INC L
                ADD A, (HL)
                LD (GameState.CursorID+2), A
                CP C
                JR C, $+3
                INC A
                LD (GameState.CursorID+0), A
                RET

                endif ; ~_MODULE_GAME_RENDER_SETTLEMENT_DRAW_
