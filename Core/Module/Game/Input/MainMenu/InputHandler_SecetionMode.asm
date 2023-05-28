
                ifndef _MODULE_GAME_INPUT_HANDLER_MAIN_MENU_SELECTION_MODE_
                define _MODULE_GAME_INPUT_HANDLER_MAIN_MENU_SELECTION_MODE_
; -----------------------------------------
; обработчик клавиш игры
; In:
;   A' - ID виртуальной клавиши
; Out:
; Corrupt:
; Note:
; -----------------------------------------
IH_SelMode:     JR NZ, .NotProcessing                                           ; переход, если виртуальная клавиша отжата
.Processing     ; опрос нажатой виртуальной клавиши
                EX AF, AF'                                                      ; переключится на ID виртуальной клавиши

                CP KEY_ID_SELECT_1                                              ; клавиша "1"
                JP Z, Select_1
                CP KEY_ID_SELECT_2                                              ; клавиша "2"
                JP Z, Select_2
                CP KEY_ID_SELECT_3                                              ; клавиша "3"
                JP Z, Select_3
                CP KEY_ID_SELECT_4                                              ; клавиша "4"
                JP Z, Select_4
                CP KEY_ID_SELECT_5                                              ; клавиша "5"
                JP Z, Select_5
                CP KEY_ID_SELECT_6                                              ; клавиша "6"
                JP Z, Select_6
                CP KEY_ID_SELECT_7                                              ; клавиша "7"
                JP Z, Select_7
                CP KEY_ID_SELECT_8                                              ; клавиша "8"
                JP Z, Select_8
                CP KEY_ID_SELECT_9                                              ; клавиша "9"
                JP Z, Select_9

.NotProcessing  SCF
                RET
Select_1:       ; проверка бита затемнения
                CHECK_MENU_FLAG MENU_FADEOUT_BIT
                RET NZ

                ; обрабатываемое меню
                LD A, (GameState.MenuID)
                CP MENU_ID_MAIN
                JP Z, StartGame
                CP MENU_ID_REDEFINE
                JP Z, RedefineUp
                CP MENU_ID_OPTIONS
                JP Z, Keyboard
                RET
Select_2:       ; проверка бита затемнения
                CHECK_MENU_FLAG MENU_FADEOUT_BIT
                RET NZ

                ; обрабатываемое меню
                LD A, (GameState.MenuID)
                CP MENU_ID_MAIN
                JP Z, Continue
                CP MENU_ID_OPTIONS
                JP Z, Kempston8
                CP MENU_ID_REDEFINE
                JP Z, RedefineDown
                RET
Select_3:       ; проверка бита затемнения
                CHECK_MENU_FLAG MENU_FADEOUT_BIT
                RET NZ

                ; обрабатываемое меню
                LD A, (GameState.MenuID)
                CP MENU_ID_MAIN
                JP Z, Options
                CP MENU_ID_OPTIONS
                JP Z, RedefineKeys
                CP MENU_ID_REDEFINE
                JP Z, RedefineLeft
                RET
Select_4:       ; проверка бита затемнения
                CHECK_MENU_FLAG MENU_FADEOUT_BIT
                RET NZ

                ; обрабатываемое меню
                LD A, (GameState.MenuID)
                CP MENU_ID_OPTIONS
                JP Z, Options.Back
                CP MENU_ID_REDEFINE
                JP Z, RedefineRight
                RET
Select_5:       ; проверка бита затемнения
                CHECK_MENU_FLAG MENU_FADEOUT_BIT
                RET NZ

                ; обрабатываемое меню
                LD A, (GameState.MenuID)
                CP MENU_ID_REDEFINE
                JP Z, RedefineSelect
                RET
Select_6:       ; проверка бита затемнения
                CHECK_MENU_FLAG MENU_FADEOUT_BIT
                RET NZ

                ; обрабатываемое меню
                LD A, (GameState.MenuID)
                CP MENU_ID_REDEFINE
                JP Z, RedefineBack
                RET
Select_7:       ; проверка бита затемнения
                CHECK_MENU_FLAG MENU_FADEOUT_BIT
                RET NZ

                ; обрабатываемое меню
                LD A, (GameState.MenuID)
                CP MENU_ID_REDEFINE
                JP Z, RedefineAccel
                RET
Select_8:       ; проверка бита затемнения
                CHECK_MENU_FLAG MENU_FADEOUT_BIT
                RET NZ

                ; обрабатываемое меню
                LD A, (GameState.MenuID)
                CP MENU_ID_REDEFINE
                JP Z, RedefineMenu
                RET
Select_9:       ; проверка бита затемнения
                CHECK_MENU_FLAG MENU_FADEOUT_BIT
                RET NZ

                ; обрабатываемое меню
                LD A, (GameState.MenuID)
                CP MENU_ID_REDEFINE
                JP Z, RedefineOpBack
                RET
StartGame:      SET_MENU_FLAGS MENU_STARTUP | MENU_UPDTAE | MENU_FADEOUT        ; установка флага первичной инициализации, обновления и эффекта затемнения

                ; включить режим опроса игровых клавиш
                LD HL, InputFlag
                LD (HL), INPUT_MODE_GAME_KEYS

                LD A, MENU_ID_START
                LD (GameState.MenuID), A

                RET
Continue:       LD A, MENU_ID_CONTINUE
                LD (GameState.MenuID), A

                SET_MENU_FLAG MENU_FADEOUT_BIT                                  ; установка флага включение эффекта затемнения
                RET
Options:        LD A, MENU_ID_OPTIONS
                LD (GameState.MenuID), A

                SET_MENU_FLAG MENU_FADEOUT_BIT                                  ; установка флага включение эффекта затемнения
                RET
.Back           LD A, MENU_ID_MAIN
                LD (GameState.MenuID), A

                SET_MENU_FLAG MENU_FADEOUT_BIT                                  ; установка флага включение эффекта затемнения
                RET
Keyboard:       SET_PAGE_BLOK_6                                                 ; включение страницы с блоком кода
                CALL Packs.Initialize.Input.SetKeyboard
                JR Options.Back
Kempston8:      SET_PAGE_BLOK_6                                                 ; включение страницы с блоком кода
                CALL Packs.Initialize.Input.SetKempston8
                JR Options.Back
RedefineKeys:   LD A, MENU_ID_REDEFINE
                LD (GameState.MenuID), A

                SET_MENU_FLAG MENU_FADEOUT_BIT                                  ; установка флага включение эффекта затемнения
                
                SET_PAGE_BLOK_6                                                 ; включение страницы с блоком кода
                JP Packs.Initialize.Input.SetRedefineKeys

RedefineUp:     LD DE, GameConfig.KeyUp
                JR TryRedefine
RedefineDown:   LD DE, GameConfig.KeyDown
                JR TryRedefine
RedefineLeft:   LD DE, GameConfig.KeyLeft
                JR TryRedefine
RedefineRight:  LD DE, GameConfig.KeyRight
                JR TryRedefine
RedefineSelect: LD DE, GameConfig.KeySelect
                JR TryRedefine
RedefineBack:   LD DE, GameConfig.KeyBack
                JR TryRedefine
RedefineAccel:  LD DE, GameConfig.KeyAcceleration
                JR TryRedefine
RedefineMenu:   LD DE, GameConfig.KeyMenu
                JR TryRedefine
TryRedefine     LD HL, InputFlag
                LD A, (HL)
                CP INPUT_MODE_REDEFINE_KEYS
                RET Z
                
                LD (HL), INPUT_MODE_REDEFINE_KEYS
                INC HL
                LD (HL), A

                EX DE, HL
                LD (HL), VK_NONE | 0x80
                RET
RedefineOpBack: LD A, (InputFlag)
                CP INPUT_MODE_REDEFINE_KEYS
                RET Z
                JR Options

                endif ; ~_MODULE_GAME_INPUT_HANDLER_MAIN_MENU_SELECTION_MODE_
