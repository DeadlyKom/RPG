
                ifndef _MODULE_GAME_RENDER_MAIN_MENU_DRAW_REDEFINE_KEYS_
                define _MODULE_GAME_RENDER_MAIN_MENU_DRAW_REDEFINE_KEYS_
; -----------------------------------------
; отображение переназначение клавиш
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
RedefineKeys:   LD HL, .Table
                LD B, .Num

.DrawLoop       PUSH BC
                
                ; чтение данных
                LD E, (HL)
                INC HL
                LD D, (HL)
                PUSH DE
                INC HL
                LD E, (HL)
                INC HL
                LD D, (HL)
                INC HL
                LD A, (HL)
                INC HL
                EX (SP), HL
                PUSH DE
                PUSH HL
                
                EXX
                POP HL
                POP DE
                CALL Packs.DrawString
                EXX

                POP HL
                POP BC
                DJNZ .DrawLoop

                XOR A
                RET

.Table          DW .UpText, #1A10
                DB #00
                DW .DownText, #2310
                DB #00
                DW .LeftText, #2C10
                DB #00
                DW .RightText, #3510
                DB #00
                DW .SelectText, #3E10
                DB #00
                DW .BackText, #4710
                DB #00
                DW .AccelText, #5010
                DB #00
                DW .MenuText, #5910
                DB #00
                DW .BackOptionText, #6B10
                DB #00
.Num            EQU ($-.Table) / 5

.UpText         BYTE "1.Up\0"
.DownText       BYTE "2.Down\0"
.LeftText       BYTE "3.Left\0"
.RightText      BYTE "4.Right\0"
.SelectText     BYTE "5.Select\0"
.BackText       BYTE "6.Back\0"
.AccelText      BYTE "7.Acceleration\0"
.MenuText       BYTE "8.Menu\0"
.BackOptionText BYTE "9.Back\0"

; GameConfig          EQU Adr.GameConfig                                          ; адрес структуры конфигурации игры


                endif ; ~_MODULE_GAME_RENDER_MAIN_MENU_DRAW_REDEFINE_KEYS_
