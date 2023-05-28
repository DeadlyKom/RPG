
                ifndef _MODULE_GAME_RENDER_START_GAME_DISPLAY_KEY_GENERATION_
                define _MODULE_GAME_RENDER_START_GAME_DISPLAY_KEY_GENERATION_
KEY_GENERATION_POS  EQU ((MENU_ROW + HEIGHT * MENU_ID_KEY_GENERATION) << 8) | MENU_COLUMN_A
KEY_GENERATION_POS_ EQU ((MENU_ROW + HEIGHT * MENU_ID_KEY_GENERATION) << 8) | MENU_COLUMN_B
; -----------------------------------------
; отображение ключ генератор
; In:
;   IY - указывает на структуру FGenerateWorld
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DispKeyGen:     ; проверка что курсор на позиции
                LD HL, GameState.Cursor
                LD A, (HL)
                CP MENU_ID_KEY_GENERATION
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
                LD A, (.Value)
                ADD A, C
                RET M                                                           ; выход, если значение стало отрицательным

                CP .Num
                RET NC                                                          ; выход, если значени стало максимальным

                LD (.Value), A

.Force          LD DE, KEY_GENERATION_POS_
                LD HL, Text.Clear
                ; -----------------------------------------
                ; отображение символа
                ; In:
                ;   HL - адрес строки
                ;   DE - координаты в пикселях (D - y, E - x)
                ; -----------------------------------------
                CALL Draw.String

.Draw           PUSH IY
                POP HL
                LD DE, KEY_GENERATION_POS_
                ; -----------------------------------------
                ; отображение символа
                ; In:
                ;   HL - адрес строки
                ;   DE - координаты в пикселях (D - y, E - x)
                ; -----------------------------------------
                JP Draw.String

.Value          DB #00
.Num            EQU 1

                endif ; ~_MODULE_GAME_RENDER_START_GAME_DISPLAY_KEY_GENERATION_
