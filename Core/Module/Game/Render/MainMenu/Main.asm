
                ifndef _MODULE_GAME_RENDER_MAIN_MENU_DRAW_MAIN_
                define _MODULE_GAME_RENDER_MAIN_MENU_DRAW_MAIN_
; -----------------------------------------
; отображение главного меню
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Main:           ; -----------------------------------------
                ;   HL - адрес строки
                ;   DE - координаты в пикселях (D - y, E - x)
                ; -----------------------------------------

                LD HL, .StartGameText
                LD DE, #1A10
                CALL Packs.DrawString

                LD HL, .ContinueText
                LD DE, #2310
                CALL Packs.DrawString

                LD HL, .OptionsText
                LD DE, #2C10
                CALL Packs.DrawString

                LD HL, .VersionText
                LD DE, #B7D0
                CALL Packs.DrawString
                
                XOR A
                RET

.StartGameText  BYTE "1.Start Game\0"
.ContinueText   BYTE "2.Continue\0"
.OptionsText    BYTE "3.Options\0"
.VersionText    BYTE "ver. "
.Build          DB '0' + BUILD, '.'
.Major          DB '0' + MAJOR, '.'
.Minor          DB '0' + MINOR
                DB #00

                endif ; ~_MODULE_GAME_RENDER_MAIN_MENU_DRAW_MAIN_
