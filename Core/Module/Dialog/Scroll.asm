
                ifndef _CORE_MODULE_DIALOG_SCROLL_
                define _CORE_MODULE_DIALOG_SCROLL_
; -----------------------------------------
; отображение скрола
; In:
;   IY - указатель на структуру FDialog
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Scroll:         ; -----------------------------------------
                ; деление A/D
                ; In :
                ;   A - делимое
                ;   C - делитель
                ; Out :
                ;   DE - результат (D - целое, E - дробная часть)
                ; -----------------------------------------
                LD A, (IY + FDialog.OptionsSize)
                LD C, (IY + FDialog.Size.Height)
                CP C
                RET C
                INC A
                CALL Math.DivFix8x8
                LD HL, #0000

                LD B, (IY + FDialog.Size.Height)
                LD C, '+' - 32

.RowLoop        PUSH HL
                PUSH DE

                LD A, H
                CP (IY + FDialog.FirstElement)

                LD A, '|' - 32
                JR C, .L1
                LD A, C
                LD C, '|' - 32
.L1             PUSH BC

                LD DE, (IY + FDialog.Coord.X)
                CP '|' - 32
                JR NZ, $+3
                INC E
                ; -----------------------------------------
                ; отображение символа на экране
                ; In:
                ;   A  - ID символа (символ - 32)
                ;   DE - координаты в пикселях (D - y, E - x)
                ; -----------------------------------------
                CALL Draw.Char

                ; переход к следующей строке
                LD A, (IY + FDialog.Coord.Y)
                ADD A, (IY + FDialog.HeightRow)
                LD (IY + FDialog.Coord.Y), A

                POP BC
                POP DE
                POP HL
                ADD HL, DE

                DJNZ .RowLoop

                ; ifdef _DEBUG
                ; LD DE, #0000
                ; CALL Console.SetCursor
                ; LD A, (IY + FDialog.FirstElement)
                ; CALL Console.DrawByte
                ; LD A, (IY + FDialog.OptionsSize)
                ; CALL Console.DrawByte
                ; endif
                
                RET

                endif ; ~_CORE_MODULE_DIALOG_SCROLL_
