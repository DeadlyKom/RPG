
                ifndef _MODULE_GAME_RENDER_START_GAME_DRAW_
                define _MODULE_GAME_RENDER_START_GAME_DRAW_
PLAY_POS        EQU ((MENU_ROW + HEIGHT * MENU_ID_PLAY) << 8) | MENU_COLUMN_A
; -----------------------------------------
; отображение меню
; In:
;   IY - указывает на структуру FGenerateWorld
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Draw:           CHECK_MENU_FLAG MENU_STARTUP_BIT
                JR Z, .Draw

                RES_FLAG MENU_STARTUP_BIT                                       ; сброс флага первичной инициализации

                ; -----------------------------------------
                ; первичная инициализация
                ; -----------------------------------------
                LD HL, GameState.Cursor
                LD (HL), #00                                                    ; текущая позиция
                INC L
                LD (HL), #05                                                    ; количество позиций
                INC L
                LD (HL), #FF                                                    ; предыдущая позиция
                INC L
                LD (HL), #00                                                    ; верхняя граница (откл)
                INC L
                LD (HL), #FF                                                    ; доступная высота (откл)
                INC L
                LD (HL), #08                                                    ; положение по горизонтали
                INC L
                LD (HL), #23                                                    ; положение по вертикали
                INC L
                LD (HL), #00                                                    ; направление

.NotStartup     ; проверка флага обновления
                CHECK_MENU_FLAG MENU_UPDTAE_BIT
                JR Z, .Draw
                RES_FLAG MENU_UPDTAE_BIT                                        ; сброс флага первичной инициализации
                
                ; -----------------------------------------
                ; обновление
                ; -----------------------------------------
                ; отображение текста "Генератор мира"
                LD HL, Text.StartGame.MapGenerator
                LD DE, #0808
                CALL Draw.String

                ; отображение "ключ генератор"
                LD HL, Text.StartGame.KeyGenerator
                LD DE, KEY_GENERATION_POS
                CALL Draw.String
                CALL DispKeyGen.Force

                ; отображение "сложность"
                LD HL, Text.StartGame.Difficulty
                LD DE, DIFFICULTY_POS
                CALL Draw.String
                CALL DispDifficulty.Force

                ; отображение "климат"
                LD HL, Text.StartGame.Climate
                LD DE, CLIMATE_POS
                CALL Draw.String
                CALL DispClimate.Force

                ; отображение "размер карты"
                LD HL, Text.StartGame.MapSize
                LD DE, MAP_SIZE_POS
                CALL Draw.String
                CALL DispMapSize.Force

                ; отображение "играть"
                LD HL, Text.StartGame.Play
                LD DE, PLAY_POS
                CALL Draw.String

.Draw           ; -----------------------------------------
                ; основной цикл рисования
                ; -----------------------------------------
                CALL DispDifficulty
                CALL DispClimate
                CALL DispMapSize
                CALL Cursor.Draw

                XOR A
                RET

                endif ; ~_MODULE_GAME_RENDER_START_GAME_DRAW_
