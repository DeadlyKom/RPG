
                ifndef _MODULE_GAME_RENDER_MAIN_MENU_DRAW_START_GAME_
                define _MODULE_GAME_RENDER_MAIN_MENU_DRAW_START_GAME_
; -----------------------------------------
; отображение продолжить
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
StartGame:      LD HL, .StartGameText
                LD DE, #1A10
                CALL Packs.DrawString

                ; LD HL, .ContinueText
                ; LD DE, #2310
                ; CALL Packs.DrawString

                ; LD HL, .OptionsText
                ; LD DE, #2C10
                ; CALL Packs.DrawString

                ; LD HL, .VersionText
                ; LD DE, #B7D0
                ; CALL Packs.DrawString
                
                XOR A
                RET

.StartGameText  BYTE "1.Start Game\0"
.ContinueText   BYTE "2.Continue\0"
.OptionsText    BYTE "3.Options\0"

                ; lua allpass
                ; Convert("3.Опции")
                ; endlua
                ; DB #00

                endif ; ~_MODULE_GAME_RENDER_MAIN_MENU_DRAW_CONTINUE_
