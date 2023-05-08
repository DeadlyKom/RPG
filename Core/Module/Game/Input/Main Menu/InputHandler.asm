
                ifndef _MODULE_GAME_INPUT_HANDLER_MAIN_MENU_
                define _MODULE_GAME_INPUT_HANDLER_MAIN_MENU_
; -----------------------------------------
; обработчик клавиш игры
; In:
;   A' - ID виртуальной клавиши
; Out:
; Corrupt:
; Note:
; -----------------------------------------
InputHandler:   JR NZ, .NotProcessing                                           ; переход, если виртуальная клавиша отжата
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

Processed:      OR A                                                            ; сброс флага переполнения (произведена обработка клавиши)
                RET

Select_1:       LD A, (Packs.MainMenu.Render.Draw.MenuType)
                SRL A
                RET C
                CP Packs.MainMenu.Render.MENU_TYPE_MAIN >> 1
                JP Z, StartGame
                CP Packs.MainMenu.Render.MENU_TYPE_REDEFINE >> 1
                JP Z, RedefineUp
                CP Packs.MainMenu.Render.MENU_TYPE_OPTIONS >> 1
                JP Z, Keyboard
                RET
Select_2:       LD A, (Packs.MainMenu.Render.Draw.MenuType)
                SRL A
                RET C
                CP Packs.MainMenu.Render.MENU_TYPE_MAIN >> 1
                JP Z, Continue
                CP Packs.MainMenu.Render.MENU_TYPE_OPTIONS >> 1
                JP Z, Kempston8
                CP Packs.MainMenu.Render.MENU_TYPE_REDEFINE >> 1
                JP Z, RedefineDown
                RET
Select_3:       LD A, (Packs.MainMenu.Render.Draw.MenuType)
                SRL A
                RET C
                CP Packs.MainMenu.Render.MENU_TYPE_MAIN >> 1
                JP Z, Options
                CP Packs.MainMenu.Render.MENU_TYPE_OPTIONS >> 1
                JP Z, RedefineKeys
                CP Packs.MainMenu.Render.MENU_TYPE_REDEFINE >> 1
                JP Z, RedefineLeft
                RET
Select_4:       LD A, (Packs.MainMenu.Render.Draw.MenuType)
                SRL A
                RET C
                CP Packs.MainMenu.Render.MENU_TYPE_OPTIONS >> 1
                JP Z, Options.Back
                CP Packs.MainMenu.Render.MENU_TYPE_REDEFINE >> 1
                JP Z, RedefineRight
                RET
Select_5:       LD A, (Packs.MainMenu.Render.Draw.MenuType)
                SRL A
                RET C
                CP Packs.MainMenu.Render.MENU_TYPE_REDEFINE >> 1
                JP Z, RedefineSelect
                RET
Select_6:       LD A, (Packs.MainMenu.Render.Draw.MenuType)
                SRL A
                RET C
                CP Packs.MainMenu.Render.MENU_TYPE_REDEFINE >> 1
                JP Z, RedefineBack
                RET
Select_7:       LD A, (Packs.MainMenu.Render.Draw.MenuType)
                SRL A
                RET C
                CP Packs.MainMenu.Render.MENU_TYPE_REDEFINE >> 1
                JP Z, RedefineAccel
                RET
Select_8:       LD A, (Packs.MainMenu.Render.Draw.MenuType)
                SRL A
                RET C
                CP Packs.MainMenu.Render.MENU_TYPE_REDEFINE >> 1
                JP Z, RedefineMenu
                RET
Select_9:       LD A, (Packs.MainMenu.Render.Draw.MenuType)
                SRL A
                RET C
                CP Packs.MainMenu.Render.MENU_TYPE_REDEFINE >> 1
                JP Z, RedefineOpBack
                RET
StartGame:      LD A, Packs.MainMenu.Render.MENU_TYPE_START | Packs.MainMenu.Render.MENU_FADEOUT_FLAG
                LD (Packs.MainMenu.Render.Draw.MenuType), A
                RET
Continue:       LD A, Packs.MainMenu.Render.MENU_TYPE_CONTINUE | Packs.MainMenu.Render.MENU_FADEOUT_FLAG
                LD (Packs.MainMenu.Render.Draw.MenuType), A
                RET
Options:        LD A, Packs.MainMenu.Render.MENU_TYPE_OPTIONS | Packs.MainMenu.Render.MENU_FADEOUT_FLAG
                LD (Packs.MainMenu.Render.Draw.MenuType), A
                RET
.Back           LD A, Packs.MainMenu.Render.MENU_TYPE_MAIN | Packs.MainMenu.Render.MENU_FADEOUT_FLAG
                LD (Packs.MainMenu.Render.Draw.MenuType), A
                RET
Keyboard:       SET_PAGE_INITIALIZE                                             ; включить страницу работы с инициализациями
                CALL Packs.Initialize.Input.SetKeyboard
                JR Options.Back
Kempston8:      SET_PAGE_INITIALIZE                                             ; включить страницу работы с инициализациями
                CALL Packs.Initialize.Input.SetKempston8
                JR Options.Back
RedefineKeys:   LD A, Packs.MainMenu.Render.MENU_TYPE_REDEFINE | Packs.MainMenu.Render.MENU_FADEOUT_FLAG
                LD (Packs.MainMenu.Render.Draw.MenuType), A
                
                SET_PAGE_INITIALIZE                                             ; включить страницу работы с инициализациями
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
TryRedefine     LD HL, RedefineFlag
                LD A, (HL)
                OR A
                RET NZ
                
                LD (HL), #FF
                EX DE, HL
                LD (HL), VK_NONE | 0x80
                RET
RedefineOpBack: LD HL, RedefineFlag
                LD A, (HL)
                OR A
                JR Z, Options
                RET
RedefineFlag    DB #00

                endif ; ~_MODULE_GAME_INPUT_HANDLER_MAIN_MENU_
