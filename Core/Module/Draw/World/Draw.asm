                ifndef _CORE_MODULE_DRAW_WORLD_DRAW_
                define _CORE_MODULE_DRAW_WORLD_DRAW_

                module World
; -----------------------------------------
; отрисовка тайлов карты мира
; In:
; Out:
; Corrupt:
; Note:
;   установить RestoreBC
;   установить 7 страницу
;   устойчивый к прерываниям
; -----------------------------------------
Draw:           ; -----------------------------------------
                ; расчёт адреса строки в экранной области
                ; -----------------------------------------
                LD A, SCR_WORLD_POS_PIX_Y
.Shake_Y        EQU $+1                                                         ; смещение карты мира по вертикали                  (кратный 2)
                ADD A, #00
                LD L, A
                LD H, HIGH Adr.ScrAdrTable
                LD A, SCR_WORLD_POS_PIX_X
.Shake_X        EQU $+1                                                         ; смещение области карты мира по горизонтали        (кратный 2)
                ADD A, #00
                AND %11111000
                RRA
                RRA
                RRA
                ADD A, (HL)
                LD E, A
                INC H
                LD D, (HL)

                HiddenScrAdr_ D                                                 ; корректировка адреса скрытого экрана
                LD (.ScreenAddress), DE

                ; -----------------------------------------
                ; расчёт смещения спрайта по горизонтали (0-3)
                ; -----------------------------------------
.Shift_X        EQU $+1
                LD A, #00
                LD C, A
                RRA
                AND %0000011
                OR HIGH Adr.WorldSprTable

                ; -----------------------------------------
                ;   значение в аккумуляторе
                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | 1  | 1  | A3 | A2 | A1 | A0 | S1 | S0 |
                ;   +----+----+----+----+----+----+----+----+
                ;
                ;   A3-A0   [7..2]  - адрес таблицы (13..10 биты адреса)
                ;   S1,S0   [1,0]   - номер сдвига
                ; -----------------------------------------

                LD (DrawColumn.Shift), A
                LD (DrawColumn.ShiftEnd), A
                LD (DrawColumn.ShiftLoop), A

                ; -----------------------------------------
                ; расчёт смещения спрайта по вертикали
                ; -----------------------------------------
                LD A, (DrawColumn.Shift_Y)
                LD L, A
                ADD A, A
                NEG
                ADD A, #20
                ; -----------------------------------------
                ;   значение в аккумуляторе
                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | 0  | 0  | 0  | O3 | O2 | O1 | O0 | 0  |
                ;   +----+----+----+----+----+----+----+----+
                ;
                ;   O3-O0   [4..1]  - смещение в спрайте
                ; -----------------------------------------
                LD (DrawColumn.OffsetSpr), A

                ; -----------------------------------------
                ; определение количество строк в знакоместе
                ; -----------------------------------------
                ; Index = (((8 - (line & 7)) >> 1) - 1) * 12
                LD A, L
                AND %00000110
                NEG
                ADD A, #06                                                      ; значение x2
                LD L, A
                ADD A, A
                ADD A, L                                                        ; х6
                ADD A, A                                                        ; x12

                ; прибавить к адресу таблицы смещение
                LD HL, .Table
                ADD A, L
                LD L, A
                ADC A, H
                SUB L
                LD H, A

                ; -----------------------------------------
                ; инициализация
                ; -----------------------------------------
                LD DE, RenderBuffer

                ; -----------------------------------------
                ; определение функции вывода
                ; -----------------------------------------
                LD A, C
                AND %00001111
                CP #08
                JR NC, .Less
                INC HL
                INC HL
                INC HL
                INC HL

                PUSH HL
                CALL .Full
                POP HL
                INC HL
                INC HL
                INC HL
                INC HL

.Half_Right     ; -----------------------------------------
                ; чтение адресов из таблицы переходов
                ; -----------------------------------------
                LD A, (HL)
                LD IXL, A
                INC HL
                LD A, (HL)
                LD IXH, A
                INC HL
                LD A, (HL)
                LD IYL, A
                INC HL
                LD A, (HL)
                LD IYH, A

                LD HL, Func.Right.x8
                LD (DrawColumn.x8), HL
                LD (DrawColumn.x8_Loop), HL
                LD (DrawColumn.x8_End), HL

                EXX
                LD HL, (.ScreenAddress)
                EXX

                ; -----------------------------------------
                ;   DE  - адрес буфера отображения (RenderBuffer)
                ;   HL' - адрес экрана вывода
                ;   IX  - адрес функции Up
                ;   IY  - адрес функции Down
                ; -----------------------------------------
                JP DrawColumn

.Less           PUSH HL
.Half_Left      ; -----------------------------------------
                ; чтение адресов из таблицы переходов
                ; -----------------------------------------
                LD A, (HL)
                LD IXL, A
                INC HL
                LD A, (HL)
                LD IXH, A
                INC HL
                LD A, (HL)
                LD IYL, A
                INC HL
                LD A, (HL)
                LD IYH, A

                LD HL, Func.Left.x8
                LD (DrawColumn.x8), HL
                LD (DrawColumn.x8_Loop), HL
                LD (DrawColumn.x8_End), HL

                EXX
                LD HL, (.ScreenAddress)
                EXX

                ; следующая колонка
                LD HL, .ScreenAddress
                INC (HL)

                ; -----------------------------------------
                ;   DE  - адрес буфера отображения (RenderBuffer)
                ;   HL' - адрес экрана вывода
                ;   IX  - адрес функции Up
                ;   IY  - адрес функции Down
                ; -----------------------------------------
                CALL DrawColumn

                POP HL
                INC HL
                INC HL
                INC HL
                INC HL

.Full           ; -----------------------------------------
                ; чтение адресов из таблицы переходов
                ; -----------------------------------------
                LD A, (HL)
                LD IXL, A
                INC HL
                LD A, (HL)
                LD IXH, A
                INC HL
                LD A, (HL)
                LD IYL, A
                INC HL
                LD A, (HL)
                LD IYH, A

                LD HL, Func.Center.x8
                LD (DrawColumn.x8), HL
                LD (DrawColumn.x8_Loop), HL
                LD (DrawColumn.x8_End), HL

                ; -----------------------------------------
                ;   DE  - адрес буфера отображения (RenderBuffer)
                ;   HL' - адрес экрана вывода
                ;   IX  - адрес функции Up
                ;   IY  - адрес функции Down
                ; -----------------------------------------
                LD C, SCR_WORLD_SIZE_X-1

.ColumnLoop     ;
                EXX
.ScreenAddress  EQU $+1
                LD HL, #0000
                EXX
                CALL DrawColumn

                ; следующая колонка
                LD HL, .ScreenAddress
                INC (HL)
                INC (HL)

                DEC C
                JR NZ, .ColumnLoop

                RET

                ;       IX      /       IY                 IX      /       IY                  IX     /       IY 
.Table          DW Func.Left.x2, Func.Left.x6,      Func.Center.x2, Func.Center.x6,     Func.Right.x2, Func.Right.x6    ; 2/6
                DW Func.Left.x4, Func.Left.x4,      Func.Center.x4, Func.Center.x4,     Func.Right.x4, Func.Right.x4    ; 4/4
                DW Func.Left.x6, Func.Left.x2,      Func.Center.x6, Func.Center.x2,     Func.Right.x6, Func.Right.x2    ; 6/2
                DW Func.Left.x8, Func.Left.x0,      Func.Center.x8, Func.Center.x0,     Func.Right.x8, Func.Right.x0    ; 8/0

                display " - Draw world:\t\t\t\t\t", /A, Draw, " = busy [ ", /D, $ - Draw, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_DRAW_WORLD_DRAW_
