
                ifndef _MODULE_GAME_INPUT_MAIN_MENU_SCAN_
                define _MODULE_GAME_INPUT_MAIN_MENU_SCAN_
; -----------------------------------------
; сканирование устроиств ввода
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Scan:           ; опрос виртуальных клавиш
                LD DE, InputHandler
                CALL Input.JumpKeys

                RET

                endif ; ~_MODULE_GAME_INPUT_MAIN_MENU_SCAN_
