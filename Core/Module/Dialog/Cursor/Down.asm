
                ifndef _CORE_MODULE_DIALOG_CURSOR_DOWN_
                define _CORE_MODULE_DIALOG_CURSOR_DOWN_
; -----------------------------------------
; перемещение курсор ниже на позицию
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Down:           LD HL, GameState.Cursor
                LD A, (HL)
                INC A
                INC L
                INC L
                CP (HL)
                RET NC

                ; сохранение предыдущей позиции
                DEC L
                DEC A
                LD (HL), A
                DEC L

                INC (HL)

                ; сброс направления (если были)
                LD HL, GameState.Cursor.Dir
                LD (HL), #00

                RET

                endif ; ~_CORE_MODULE_DIALOG_CURSOR_DOWN_
