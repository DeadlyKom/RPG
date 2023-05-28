
                ifndef _MODULE_GAME_RENDER_START_GAME_DISPLAY_CLIMATE_
                define _MODULE_GAME_RENDER_START_GAME_DISPLAY_CLIMATE_
CLIMATE_POS     EQU ((MENU_ROW + HEIGHT * MENU_ID_CLIMATE) << 8) | MENU_COLUMN_A
CLIMATE_POS_    EQU ((MENU_ROW + HEIGHT * MENU_ID_CLIMATE) << 8) | MENU_COLUMN_B
; -----------------------------------------
; отображение климата игры
; In:
;   IY - указывает на структуру FGenerateWorld
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DispClimate:    ; проверка что курсор на позиции
                LD HL, GameState.Cursor
                LD A, (HL)
                CP MENU_ID_CLIMATE
                RET NZ                                                          ; выход, курсор не на позиции

                ; проверка что значения изменились
                LD HL, GameState.Cursor.Dir
                LD A, (HL)                                                      ; направление движения (для инпута)
                                                                                ;   #01 - вперёд (+1 позиция)
                                                                                ;   #FF - назда (-1 позиция)
                OR A
                RET Z                                                           ; выход, позиция не изменилась

                LD (HL), #00                                                    ; сброс направления

                ; приращение значения
                LD C, A
                LD A, (IY + FGenerateWorld.Climate)
                ADD A, C
                RET M                                                           ; выход, если значение стало отрицательным

                CP .Num
                RET NC                                                          ; выход, если значени стало максимальным

                LD (IY + FGenerateWorld.Climate), A

.Force          LD DE, CLIMATE_POS_
                LD HL, Text.Clear
                ; -----------------------------------------
                ; отображение символа
                ; In:
                ;   HL - адрес строки
                ;   DE - координаты в пикселях (D - y, E - x)
                ; -----------------------------------------
                CALL Draw.String

.Draw           LD A, (IY + FGenerateWorld.Climate)
                ADD A, A
                ADD A, LOW .Table
                LD L, A
                ADC A, HIGH .Table
                SUB L
                LD H, A
                LD E, (HL)
                INC HL
                LD D, (HL)

                LD HL, CLIMATE_POS_
                EX DE, HL
                ; -----------------------------------------
                ; отображение символа
                ; In:
                ;   HL - адрес строки
                ;   DE - координаты в пикселях (D - y, E - x)
                ; -----------------------------------------
                JP Draw.String

.Table          DW Text.Climate.Temperate, Text.Climate.Harsh
.Num            EQU ($-.Table) / 2

                endif ; ~_MODULE_GAME_RENDER_START_GAME_DISPLAY_CLIMATE_
