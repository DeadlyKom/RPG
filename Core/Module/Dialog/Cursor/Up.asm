
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
                
                ; сравнить сумму текущей и верхеней границы
                ; с верхней гнаницей массива (с нулём)
                LD A, (HL)
                INC L
                INC L
                INC L
                LD C, (HL)
                ADD A, C
                RET Z
                
                ; проверяем выход за доступный предел
                SUB C
                JR Z, .ScrollUp

                ; сохранение предыдущей позиции
                DEC L
                LD (HL), A

                ; уменьшаем позицию
                DEC L
                DEC L
                DEC (HL)

.Reset          ; сброс направления (если был)
                LD HL, GameState.Cursor.Dir
                LD (HL), #00

                RET

.ScrollUp       ; уменьшение верхней позиции
                DEC (HL)

                ; установка флага обновления, необходимости скролить меню вверх
                SET_MENU_FLAGS MENU_UPDTAE | MENU_SCROLL | MENU_SCROLL_UP
                JR .Reset

                endif ; ~_CORE_MODULE_DIALOG_CURSOR_UP_
