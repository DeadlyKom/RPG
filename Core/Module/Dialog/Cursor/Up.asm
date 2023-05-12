
                ifndef _CORE_MODULE_DIALOG_CURSOR_UP_
                define _CORE_MODULE_DIALOG_CURSOR_UP_
; -----------------------------------------
; перемещение курсор выше на позицию
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Up:             LD HL, GameState.Cursor
                LD A, (HL)
                OR A
                RET Z

                ; сохранение предыдущей позиции
                INC L
                LD (HL), A
                DEC L
                DEC (HL)

                ; сброс направления (если были)
                LD HL, GameState.Cursor.Dir
                LD (HL), #00

                RET

                endif ; ~_CORE_MODULE_DIALOG_CURSOR_UP_
