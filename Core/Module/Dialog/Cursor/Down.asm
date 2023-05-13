
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
                
                ; сравнить сумму текущей и верхеней границы
                ; с нижней гнаницей массива
                LD A, (HL)
                INC L
                INC L
                INC L
                LD C, (HL)
                DEC L
                DEC L
                ADD A, C
                INC A
                CP (HL)
                RET NC
                SUB C

                ; проверяем выход за доступный предел
                INC L
                INC L
                INC L
                CP (HL)
                JR NC, .ScrollDown

                ; сохранение предыдущей позиции
                DEC L
                DEC L
                DEC A
                LD (HL), A

                ; увеличиваем позицию
                DEC L
                DEC L
                INC (HL)

.Reset          ; сброс направления (если был)
                LD HL, GameState.Cursor.Dir
                LD (HL), #00

                ; установка флага обновления скрола
                SET_MENU_FLAG MENU_UPDATE_SCROLL_BIT

                RET

.ScrollDown     ; увеличение верхней позиции
                DEC L
                INC (HL)

                ; установка флага обновления, необходимости скролить меню вниз
                SET_MENU_FLAGS MENU_UPDTAE | MENU_SCROLL | MENU_SCROLL_DOWN
                JR .Reset

                endif ; ~_CORE_MODULE_DIALOG_CURSOR_DOWN_
