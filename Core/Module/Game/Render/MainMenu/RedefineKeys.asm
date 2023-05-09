
                ifndef _MODULE_GAME_RENDER_MAIN_MENU_DRAW_REDEFINE_KEYS_
                define _MODULE_GAME_RENDER_MAIN_MENU_DRAW_REDEFINE_KEYS_
; -----------------------------------------
; отображение переназначение клавиш
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
RedefineKeys:   ; инициализация
                LD HL, .Table
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
                LD C, (HL)
                INC HL
                LD B, (HL)
                INC HL
                EX (SP), HL
                PUSH HL
                PUSH DE
                PUSH BC
                
                EXX
                POP BC
                LD A, C
                OR B
                JR Z, .Skip
                POP DE
                PUSH DE
                CALL DrawKey
.Skip           POP DE
                POP HL
                CALL Packs.DrawString
                EXX

                POP HL
                POP BC
                DJNZ .DrawLoop

                XOR A
                RET

.Table          DW .UpText, #1A10
                DW GameConfig.KeyUp
                DW .DownText, #2310
                DW GameConfig.KeyDown
                DW .LeftText, #2C10
                DW GameConfig.KeyLeft
                DW .RightText, #3510
                DW GameConfig.KeyRight
                DW .SelectText, #3E10
                DW GameConfig.KeySelect
                DW .BackText, #4710
                DW GameConfig.KeyBack
                DW .AccelText, #5010
                DW GameConfig.KeyAcceleration
                DW .MenuText, #5910
                DW GameConfig.KeyMenu
                DW .BackOptionText, #6B10
                DW #0000
.Num            EQU ($-.Table) / 6

.UpText         BYTE "1.Up\0"
.DownText       BYTE "2.Down\0"
.LeftText       BYTE "3.Left\0"
.RightText      BYTE "4.Right\0"
.SelectText     BYTE "5.Select\0"
.BackText       BYTE "6.Back\0"
.AccelText      BYTE "7.Acceleration\0"
.MenuText       BYTE "8.Menu\0"
.BackOptionText BYTE "9.Back\0"

; -----------------------------------------
; отображение переназначение клавиш
; In:
;   A  - номер виртуальной клавиши
;   DE - координаты в пикселях (D - y, E - x)
;   BC - адрес GameConfig опрашиваемой клавиши
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DrawKey:        LD A, (BC)
                PUSH AF
                ADD A, A
                CALL C, Clear
                POP AF
                RES 7, A

                ; проверка отображения выбора клавиши
                CP VK_NONE
                JR Z, SelectKey

                CP VK_KEMPSTON_RIGHT
                LD HL, Keyboard
                JR C, .CalcAdrText                                              ; перехд, если клавиатура

                ; кемпстон
                SUB VK_KEMPSTON_RIGHT
                LD HL, Kempston

.CalcAdrText    ; расчёт адрес текста в таблице
                ADD A, A
                ADD A, L
                LD L, A
                ADC A, H
                SUB L
                LD H, A

                ; чтение адреса строки
                LD A, (HL)
                INC HL
                LD H, (HL)
                LD L, A

.Draw           ; смещение по горизонтали
                LD A, E
                ADD A, #70
                LD E, A

                ; отображение символа
                ;   HL - адрес строки
                ;   DE - координаты в пикселях (D - y, E - x)
                JP Packs.DrawString

SelectKey:      LD HL, (TickCounterRef)
                LD BC, (.OldTickCounter)
                OR A
                SBC HL, BC
                LD A, L
                CP #08
                JR C, .Draw
                ADD HL, BC
                LD (.OldTickCounter), HL

                CALL Clear

                ; flip-flop
                LD HL, .FlipFlop
                DEC (HL)

.Draw           LD HL, .FlipFlop
                LD A, (HL)
                OR A
                LD HL, .NoneText1
                JR Z, DrawKey.Draw
                DEC A
                LD HL, .NoneText2
                JR Z, DrawKey.Draw
                LD HL, .FlipFlop
                LD (HL), #02
                LD HL, .NoneText3
                JR  DrawKey.Draw
.OldTickCounter DW #0000
.FlipFlop       DB #00
.NoneText1      BYTE "?\0"
.NoneText2      BYTE "+\0"
.NoneText3      BYTE ".\0"
Clear:          LD A, (BC)
                RES 7, A
                LD (BC), A
                
                PUSH DE
                LD HL, .Space

                ; смещение по горизонтали
                LD A, E
                ADD A, #70
                AND %11111000
                LD E, A

                ; отображение символа
                ;   HL - адрес строки
                ;   DE - координаты в пикселях (D - y, E - x)
                CALL Packs.DrawString
                POP DE
                RET
.Space          BYTE "^^^^^^^^^^^^\0"
Keyboard:
.Table          DW .Row0+0, .Row0+11, .Row0+13, .Row0+15, .Row0+17
                DW .Row1+0, .Row1+2,  .Row1+4,  .Row1+6,  .Row1+8
                DW .Row2+0, .Row2+2,  .Row2+4,  .Row2+6,  .Row2+8
                DW .Row3+0, .Row3+2,  .Row3+4,  .Row3+6,  .Row3+8
                DW .Row4+0, .Row4+2,  .Row4+4,  .Row4+6,  .Row4+8
                DW .Row5+0, .Row5+2,  .Row5+4,  .Row5+6,  .Row5+8
                DW .Row6+0, .Row6+6,  .Row6+8,  .Row6+10, .Row6+12
                DW .Row7+0, .Row7+6,  .Row7+19, .Row7+21, .Row7+23

.Row0           BYTE "CAPS SHIFT\0", "Z\0",            "X\0", "C\0", "V\0"
.Row1           BYTE "A\0",          "S\0",            "D\0", "F\0", "G\0"
.Row2           BYTE "Q\0",          "W\0",            "E\0", "R\0", "T\0"
.Row3           BYTE "1\0",          "2\0",            "3\0", "4\0", "5\0"
.Row4           BYTE "0\0",          "9\0",            "8\0", "7\0", "6\0"
.Row5           BYTE "P\0",          "O\0",            "I\0", "U\0", "Y\0"
.Row6           BYTE "ENTER\0",      "L\0",            "K\0", "J\0", "H\0"
.Row7           BYTE "SPACE\0",      "SYMBOL SHIFT\0", "M\0", "N\0", "B\0"
Kempston:
.Table          DW .Right, .Left, .Dowm, .Up, .B, .C, .A, .Start
.Right          BYTE "KEMPSTON RIGHT\0"                                         ; #40
.Left           BYTE "KEMPSTON LEFT\0"                                          ; #41
.Dowm           BYTE "KEMPSTON DOWN\0"                                          ; #42
.Up             BYTE "KEMPSTON UP\0"                                            ; #43
.B              BYTE "BUTTON B\0"                                               ; #44
.C              BYTE "BUTTON C\0"                                               ; #45
.A              BYTE "BUTTON A\0"                                               ; #46
.Start          BYTE "KEMPSTON START\0"                                         ; #47

                endif ; ~_MODULE_GAME_RENDER_MAIN_MENU_DRAW_REDEFINE_KEYS_
