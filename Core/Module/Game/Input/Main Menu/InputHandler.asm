
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
                JR Z, Select_1
                CP KEY_ID_SELECT_2                                              ; клавиша "2"
                JR Z, Select_2
                CP KEY_ID_SELECT_3                                              ; клавиша "3"
                JR Z, Select_3
                CP KEY_ID_SELECT_4                                              ; клавиша "4"
                JR Z, Select_4
                CP KEY_ID_SELECT_9                                              ; клавиша "9"
                JR Z, Select_9

.NotProcessing  SCF
                RET

Processed:      OR A                                                            ; сброс флага переполнения (произведена обработка клавиши)
                RET

Select_1:       LD A, (Packs.MainMenu.Render.Draw.MenuType)
                SRL A
                RET C
                CP Packs.MainMenu.Render.MENU_TYPE_MAIN >> 1
                JP Z, StartGame
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
                RET
Select_3:       LD A, (Packs.MainMenu.Render.Draw.MenuType)
                SRL A
                RET C
                CP Packs.MainMenu.Render.MENU_TYPE_MAIN >> 1
                JP Z, Options
                CP Packs.MainMenu.Render.MENU_TYPE_OPTIONS >> 1
                JP Z, RedefineKeys
                RET
Select_4:       LD A, (Packs.MainMenu.Render.Draw.MenuType)
                SRL A
                RET C
                CP Packs.MainMenu.Render.MENU_TYPE_OPTIONS >> 1
                JP Z, Options.Back
                RET

Select_9:       LD A, (Packs.MainMenu.Render.Draw.MenuType)
                SRL A
                RET C
                CP Packs.MainMenu.Render.MENU_TYPE_REDEFINE >> 1
                JP Z, Options
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

StartGame:      RET
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

                endif ; ~_MODULE_GAME_INPUT_HANDLER_MAIN_MENU_
