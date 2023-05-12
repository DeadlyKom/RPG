
                ifndef _MODULE_GAME_RENDER_MAIN_MENU_DRAW_OPTIONS_
                define _MODULE_GAME_RENDER_MAIN_MENU_DRAW_OPTIONS_
; -----------------------------------------
; отображение меню опций
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Options:        ; -----------------------------------------
                ; отображение символа
                ; In:
                ;   HL - адрес строки
                ;   DE - координаты в пикселях (D - y, E - x)
                ; -----------------------------------------

                LD HL, .KeyboardText
                LD DE, #1A10
                CALL Draw.String

                LD HL, .KempstonText
                LD DE, #2310
                CALL Draw.String

                LD HL, .RedefineText
                LD DE, #2C10
                CALL Draw.String

                LD HL, .BackText
                LD DE, #3510
                CALL Draw.String

                XOR A
                RET

.KeyboardText   BYTE "1.Keyboard\0"
.KempstonText   BYTE "2.Kempston 8-button\0"
.RedefineText   BYTE "3.Redefine keys\0"
.BackText       BYTE "4.Back\0"

                endif ; ~_MODULE_GAME_RENDER_MAIN_MENU_DRAW_OPTIONS_
