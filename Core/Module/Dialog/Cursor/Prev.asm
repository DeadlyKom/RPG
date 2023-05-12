
                ifndef _CORE_MODULE_DIALOG_CURSOR_PREV_
                define _CORE_MODULE_DIALOG_CURSOR_PREV_
; -----------------------------------------
; изменение значения на предыдущее
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Prev:           LD HL, GameState.Cursor.Dir
                LD (HL), CURSOR_DEC

                RET

                endif ; ~_CORE_MODULE_DIALOG_CURSOR_PREV_
