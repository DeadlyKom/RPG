
                ifndef _MODULE_GAME_RENDER_MAIN_MENU_DRAW_START_GAME_
                define _MODULE_GAME_RENDER_MAIN_MENU_DRAW_START_GAME_
KEY_GEN_ID      EQU 0x00
FREQ_GEN_ID     EQU 0x01
DIFFICULTY_ID   EQU 0x02
SETTLES_NUM_ID  EQU 0x03
PLAY_ID         EQU 0x04
; -----------------------------------------
; отображение продолжить
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
StartGame:      ; проверка флага первичной инициализации
                CHECK_MENU_FLAG MENU_STARTUP_BIT
                JR Z, .Draw

                RES_FLAG MENU_STARTUP_BIT                                       ; сброс флага первичной инициализации

                ; -----------------------------------------
                ; первичная инициализация
                ; -----------------------------------------
                LD HL, GameState.Cursor
                LD (HL), #FF                                                    ; текущая позиция
                INC L
                LD (HL), #00                                                    ; предыдущая позиция
                INC L
                LD (HL), #05                                                    ; количество позиций
                INC L
                LD (HL), #00                                                    ; направление

                ; принудительное отображение
                CALL UpdateKeyGen.Clear
                CALL UpdateFreqGen.Clear
                CALL UpdateDif.Clear

.Draw           ; -----------------------------------------
                ; основное отображение
                ; -----------------------------------------

                LD HL, .MapGenerator
                LD DE, #0808
                CALL Packs.DrawString

                LD HL, .KeyGenerator
                LD DE, #2310
                CALL Packs.DrawString

                LD HL, .FreqGenerator
                LD DE, #2C10
                CALL Packs.DrawString

                LD HL, .Difficulty
                LD DE, #3510
                CALL Packs.DrawString

                LD HL, .SettlementsNum
                LD DE, #3E10
                CALL Packs.DrawString
                

                ; LD HL, .DistSettlements
                ; LD DE, #3E10
                ; CALL Packs.DrawString

                ; LD HL, .FriendlySettlement
                ; LD DE, #4710
                ; CALL Packs.DrawString

                ; LD HL, .NeutralSettlement
                ; LD DE, #5010
                ; CALL Packs.DrawString

                ; LD HL, .HostileSettlement
                ; LD DE, #5910
                ; CALL Packs.DrawString

                LD HL, .Play
                LD DE, #4710
                CALL Packs.DrawString
                ; -----------------------------------------
                ; обновление
                ; -----------------------------------------
                CALL UpdateCursor
                CALL UpdateKeyGen
                CALL UpdateFreqGen
                CALL UpdateDif

                ; LD A, (GameState.Cursor)
                ; CP KEY_GEN_ID
                ; JR Z, $
                ; CP DIFFICULTY_ID
                ; JR Z, UpdateDif
                ; CP SETTLES_NUM_ID
                ; JR Z, $
                
                XOR A
                RET

.MapGenerator   lua allpass
                Convert ("Генератор карты")
                endlua
.KeyGenerator   lua allpass
                Convert("Ключ генератора")
                endlua
.FreqGenerator  lua allpass
                Convert("Частота генератора")
                endlua
.Difficulty     lua allpass
                Convert("Сложность")
                endlua
.SettlementsNum lua allpass
                Convert("Количество поселений")
                endlua
; .DistSettlements lua allpass
;                 Convert("Расстояние между поселениями")
;                 endlua
; .FriendlySettlement lua allpass
;                 Convert("Частота дружественных поселений")
;                 endlua
; .NeutralSettlement lua allpass
;                 Convert("Частота нейтральных поселений")
;                 endlua
; .HostileSettlement lua allpass
;                 Convert("Частота враждебных поселений")
;                 endlua
.Play           lua allpass
                Convert("Играть")
                endlua
UpdateCursor:   LD HL, GameState.Cursor
                LD A, (HL)
                INC A
                JR Z, .Draw

                INC L
                DEC A
                CP (HL)
                RET Z                                                           ; позиция не изменилась

                PUSH AF
                PUSH HL
.Clear          LD A, (HL)
                LD C, '^' - 32
                CALL .DrawCursor
                POP HL
                POP AF

.Draw           ; обновить старую позицию (отк повторной отрисовки)
                LD (HL), A
                LD C, '>' - 32

.DrawCursor     ; расчёт положение курсора
                INC A
                LD B, A
                LD A, -9

.Mult           ADD A, #09
                DJNZ .Mult

                ADD A, #23
                LD D, A
                LD E, #08
                LD A, C
                JP Packs.DrawChar
UpdateKeyGen:   ; проверка что курсор на позиции
                LD HL, GameState.Cursor
                LD A, (HL)
                CP KEY_GEN_ID
                RET NZ                                                          ; выход, курсор не на позиции

                ; проверка что значения изменились
                INC L
                INC L
                INC L
                LD A, (HL)                                                      ; направление движения (для инпута)
                                                                                ;   #01 - вперёд (+1 позиция)
                                                                                ;   #FF - назда (-1 позиция)
                OR A
                RET Z                                                           ; выход, позиция не изменилась

                LD (HL), #00                                                    ; сброс направления

                LD HL, (GameConfig.Seed)
                LD C, A
                ADD A, A
                SBC A, A
                LD B, A
                ADD HL, BC
                LD (GameConfig.Seed), HL

.Clear          LD DE, #23A0
                LD HL, ClearText
                CALL Packs.DrawString

.Draw           LD HL, (GameConfig.Seed)
                CALL Convert.NumberToString_16
                EX DE, HL
                XOR A
                LD (HL), A
                SBC HL, BC
                LD DE, #23A0
                JP Packs.DrawString
UpdateFreqGen:  ; проверка что курсор на позиции
                LD HL, GameState.Cursor
                LD A, (HL)
                CP FREQ_GEN_ID
                RET NZ                                                          ; выход, курсор не на позиции

                ; проверка что значения изменились
                INC L
                INC L
                INC L
                LD A, (HL)                                                      ; направление движения (для инпута)
                                                                                ;   #01 - вперёд (+1 позиция)
                                                                                ;   #FF - назда (-1 позиция)
                OR A
                RET Z                                                           ; выход, позиция не изменилась

                LD (HL), #00                                                    ; сброс направления

                LD C, A
                LD A, (GameConfig.Frequency)
                ADD A, C
                LD (GameConfig.Frequency), A

.Clear          LD DE, #2CA0
                LD HL, ClearText
                CALL Packs.DrawString

.Draw           LD A, (GameConfig.Frequency)
                CALL Convert.NumberToString_8
                EX DE, HL
                XOR A
                LD (HL), A
                SBC HL, BC
                LD DE, #2CA0
                JP Packs.DrawString
UpdateDif:      ; проверка что курсор на позиции
                LD HL, GameState.Cursor
                LD A, (HL)
                CP DIFFICULTY_ID
                RET NZ                                                          ; выход, курсор не на позиции

                ; проверка что значения изменились
                INC L
                INC L
                INC L
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

                CP #04
                RET NC                                                          ; выход, если значени стало максимальным

                LD (.Value), A

.Clear          LD DE, #35A0
                LD HL, ClearText
                CALL Packs.DrawString

.Draw           LD A, (.Value)
                ADD A, A
                ADD A, LOW .Table
                LD L, A
                ADC A, HIGH .Table
                SUB L
                LD H, A
                LD E, (HL)
                INC HL
                LD D, (HL)

                LD HL, #35A0
                EX DE, HL
                JP Packs.DrawString

.Value          DB #00
.Table          DW .Easy, .Normal, .Nightmare, .Hardcore
.Easy           lua allpass
                Convert("лёгкая")
                endlua
.Normal         lua allpass
                Convert("нормальная")
                endlua
.Nightmare      lua allpass
                Convert("кошмарная")
                endlua
.Hardcore       lua allpass
                Convert("ужасная")
                endlua
ClearText       BYTE "^^^^^^^^^\0"

                endif ; ~_MODULE_GAME_RENDER_MAIN_MENU_DRAW_CONTINUE_
