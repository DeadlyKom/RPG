
                ifndef _CORE_MODULE_DIALOG_CURSOR_NEXT_
                define _CORE_MODULE_DIALOG_CURSOR_NEXT_
; -----------------------------------------
; изменение значения на следующее
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Next:           LD HL, GameState.Cursor.Dir
                LD (HL), CURSOR_INC

                RET

                endif ; ~_CORE_MODULE_DIALOG_CURSOR_NEXT_
