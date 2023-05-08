
                ifndef _MODULE_GAME_INPUT_HANDLER_MAIN_MENU_GAME_MODE_
                define _MODULE_GAME_INPUT_HANDLER_MAIN_MENU_GAME_MODE_
INPUT           EQU 0x00
INPUT_WASD      EQU 0x00
INPUT_QAOP      EQU 0x01
INPUT_KEMPSTON  EQU 0x02
SLOT            EQU 0x01
PARTICLE        EQU 0x02
RESUME          EQU 0x03
; -----------------------------------------
; обработчик клавиш игры
; In:
;   A' - ID виртуальной клавиши
; Out:
; Corrupt:
; Note:
; -----------------------------------------
IH_GameMode:    JR NZ, .NotProcessing                                           ; переход, если виртуальная клавиша отжата
.Processing     ; опрос нажатой виртуальной клавиши
                EX AF, AF'                                                      ; переключится на ID виртуальной клавиши

                CP KEY_ID_UP                                                    ; клавиша "вверх"
                JR Z, Up
                CP KEY_ID_DOWN                                                  ; клавиша "вниз"
                JR Z, Down
                CP KEY_ID_LEFT                                                  ; клавиша "влево"
                JP Z, Left
                CP KEY_ID_RIGHT                                                 ; клавиша "вправо"
                JP Z, Right
                CP KEY_ID_SELECT                                                ; клавиша "выбор"
                JP Z, Selected
                CP KEY_ID_BACK                                                  ; клавиша "отмена/назад"
                JP Z, Back
                ; CP KEY_ID_ACCELERATION                                          ; клавиша "ускорить"
                ; JP Z, $
                ; CP KEY_ID_MENU                                                  ; клавиша "меню/пауза"
                ; JR Z, $

.NotProcessing  SCF
                RET

Processed:      OR A                                                            ; сброс флага переполнения (произведена обработка клавиши)
                RET
Up:             LD HL, GameState.Cursor
                LD A, (HL)
                OR A
                JR Z, Processed

                ; сохранение предыдущей позиции
                INC L
                LD (HL), A
                DEC L
                DEC (HL)

                ; сброс направления (если были)
                LD HL, GameState.Cursor.Dir
                LD (HL), #00
                JR Processed
Down:           LD HL, GameState.Cursor
                LD A, (HL)
                INC A
                INC L
                INC L
                CP (HL)
                JR NC, Processed

                ; сохранение предыдущей позиции
                DEC L
                DEC A
                LD (HL), A
                DEC L

                INC (HL)

                ; сброс направления (если были)
                LD HL, GameState.Cursor.Dir
                LD (HL), #00
                JR Processed
Left:           LD HL, GameState.Cursor.Dir
                LD (HL), CURSOR_DEC
                RET
Right:          LD HL, GameState.Cursor.Dir
                LD (HL), CURSOR_INC
                RET
Selected:       LD HL, GameState.Cursor
                LD A, (HL)
                CP Packs.MainMenu.Render.KEY_GEN_ID
                JR Z, .KeyGen_RND
                CP Packs.MainMenu.Render.PLAY_ID
                JR Z, $

                RET

.KeyGen_RND     CALL Math.Rand8
                LD (GameConfig.Seed+0), A
                CALL Math.Rand8
                LD (GameConfig.Seed+1), A

                SET_MENU_FLAG MENU_STARTUP_BIT                                  ; установка флага первичной инициализации
                RET
Back:           LD A, Packs.MainMenu.Render.MENU_TYPE_MAIN | Packs.MainMenu.Render.MENU_FADEOUT_FLAG
                LD (Packs.MainMenu.Render.Draw.MenuType), A
                
                ; включить режим выбора цифрами
                LD HL, InputFlag
                LD (HL), INPUT_MODE_SELECT_KEYS
                
                RET

                endif ; ~_MODULE_GAME_INPUT_HANDLER_MAIN_MENU_GAME_MODE_
