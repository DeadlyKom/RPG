
                ifndef _CORE_MODULE_DIALOG_DISPLAY_
                define _CORE_MODULE_DIALOG_DISPLAY_
; -----------------------------------------
; отображение списка доступных построек
; In:
;   IY - указатель на структуру FDialog
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Display:        ; инициализация
                LD HL, (IY + FDialog.Available)
                LD DE, (IY + FDialog.Options)

                ; подготовка первого видимого элемента
                LD A, (IY + FDialog.FirstElement)
                OR A
                JR Z, .Draw

                LD C, A
                AND #07
                LD B, A
                SRL C
                SRL C
                SRL C
                INC C
                JR .SkipLoop

.Loop           LD B, #08                                                       ; новый байт
                INC HL                                                          ; следующий байт для сдвига

.SkipLoop       SRL (HL)
                DEC (IY + FDialog.SkipElement)
                JR NZ, $+8
                INC DE
                INC DE
                DEC (IY + FDialog.OptionsSize)
                RET Z
                DEC (IY + FDialog.OptionsSize)
                RET Z                                                           ; выход, если количество элементов в масиве равно 0
                
                ; следующий адрес в таблице
                INC DE
                INC DE

                DJNZ .SkipLoop

                DEC C
                JR NZ, .Loop

.Draw           ; количество оставшихся бит в байте (для сдвига)
                LD A, (IY + FDialog.FirstElement)
                CPL
                AND #07
                INC A
                LD B, A

                ; -----------------------------------------
                ; HL - адрес маски доступных элементов
                ; DE - адрес массива вариантов (текущий)
                ; B  - количество оставшихся бит в байте
                ; -----------------------------------------

.RowLoop        ; проверка пропуска элемента
                DEC (IY + FDialog.SkipElement)
                JR Z, .NextElement

                ; уменьшение доступной области по вертикали
                LD A, (IY + FDialog.Size.Height)
                SUB (IY + FDialog.HeightRow)
                RET C                                                           ; выход, если новая строка не поместится
                LD (IY + FDialog.Size.Height), A

                ; проверка нааличия бита
                SRL (HL)
                JR NC, .NextElement                                             ; переход к следующему элементу

                ; сохранение
                PUSH HL
                PUSH DE
                PUSH BC

                ; отображение строки
                EX DE, HL
                LD E, (HL)
                INC HL
                LD D, (HL)
                LD HL, Adr.SortBuffer
                PUSH HL
                EX DE, HL
                ; -----------------------------------------
                ; копирование строки
                ; In:
                ;   HL - адрес места назначения
                ;   DE - адрес источника (включая завершающий нулевой символ)
                ; -----------------------------------------
                CALL Utils.Strcpy

                POP HL
                LD DE, (IY + FDialog.Coord)

                ; -----------------------------------------
                ; отображение символа
                ; In:
                ;   HL - адрес строки
                ;   DE - координаты в пикселях (D - y, E - x)
                ; -----------------------------------------
                CALL Draw.String

                ; восстановление
                POP BC
                POP DE
                POP HL

                ; переход к следующей строке
                LD A, (IY + FDialog.Coord.Y)
                ADD A, (IY + FDialog.HeightRow)
                LD (IY + FDialog.Coord.Y), A

.NextElement    DEC (IY + FDialog.OptionsSize)
                RET Z                                                           ; выход, если количество элементов в масиве равно 0

                ; следующий адрес в таблице
                INC DE
                INC DE

                DJNZ .RowLoop

                LD B, #08                                                       ; новый байт
                INC HL                                                          ; следующий байт для сдвига
                JR .RowLoop

                endif ; ~_CORE_MODULE_DIALOG_DISPLAY_
