                ifndef _CORE_MODULE_DRAW_WORLD_DRAW_
                define _CORE_MODULE_DRAW_WORLD_DRAW_

                module World
; -----------------------------------------
; отрисовка тайлов карты мира
; In:
; Out:
; Corrupt:
; Note:
;   устойчивый к прерываниям
; -----------------------------------------
Draw:           ; -----------------------------------------
                ; расчёт адреса строки в экранной области
                ; -----------------------------------------
                LD A, SCR_WORLD_POS_PIX_Y
.Offset_Y       EQU $+1                                                         ; смещение карты мира по вертикали
                ADD A, #00
                LD L, A
                LD H, HIGH Adr.ScrAdrTable
                LD A, SCR_WORLD_POS_PIX_X
.Offset_X       EQU $+1                                                         ; смещение области карты мира по горизонтали
                ADD A, #00
.Shift_X        EQU $+1                                                         ; смещение в области карты мира по горизонтали
                ADD A, #00
                LD C, A
                AND %11111000
                RRA
                RRA
                RRA
                ADD A, (HL)
                LD E, A
                INC H
                LD D, (HL)

                HiddenScreenAdr_ D

                ; инициализация адреса экрана, для цикличного вывода стобцов
                LD (.ScreenAddress), DE
                LD A, D
                AND %11111000
                LD (Kernel.LD.NextRow.ScreenAddress), A
                EX AF, AF'

                ; -----------------------------------------
                ; определение количество строк в знакоместе
                ; -----------------------------------------
                LD A, L
                AND %00000111
                NEG
                ADD A, #08
                SRL A
                LD (DrawColumn.Rows_x2), A
                LD B, A

                ; -----------------------------------------
                ; определение функции вывода
                ; -----------------------------------------
                LD A, C
                AND %00000111
                LD HL, Table.WorldNoShift
                JR Z, .IsNotShift                                               ; вывод без смещением

                LD HL, Table.WorldShift
                RRA

                ; -----------------------------------------
                ; расчёт смещения спрайта
                ; -----------------------------------------
                DEC A
                JR Z, .First
                DEC A
                JR Z, .Second
                ADD A, #32
.Second         ADD A, #32
.First          ADD A, #22

.IsNotShift     LD (.Table), HL
                ; -----------------------------------------
                ; A - хранит смещение спрайта
                ;   0 - 0                               = 0
                ;   1 - (2 + 32)                        = 34
                ;   2 - (2 + 32) + (2 + 48)             = 84
                ;   3 - (2 + 32) + (2 + 48) + (2 + 48)  = 134
                ; -----------------------------------------
                LD (DrawColumn.Offset), A

                ; ; -----------------------------------------
                ; ; чтение адреса из таблицы переходов
                ; ; -----------------------------------------
                ; LD A, (HL)
                ; LD IYL, A
                ; INC HL
                ; LD A, (HL)
                ; LD IYH, A

                ;
                LD HL, -2
                ADD HL, SP
                LD (DrawColumn.ContainerSP), HL
                RestoreDE

                EX DE, HL
                EXX

                LD IX, RenderBuffer

                ; -----------------------------------------
                ;   HL' - адрес экрана вывода
                ;   B'  - количество строк в знакоместе
                ;   IX  - адрес буфера отображения (RenderBuffer)
                ;   IY  - адрес функции рисования тайла
                ; -----------------------------------------

                ; -----------------------------------------
                ; чтение адреса из таблицы переходов
                ; -----------------------------------------
                LD A, (.Shift_X)
                OR A
                JR Z, .L2

                EXX
                DEC L
                EXX
                
.Table          EQU $+1
                LD HL, #0000
                DEC HL
                DEC HL
                
                CP 8
                JR NC, $+7
                EXX
                INC L
                EXX
                DEC HL
                DEC HL

                LD A, (HL)
                LD IYL, A
                INC HL
                LD A, (HL)
                LD IYH, A

                CALL DrawColumn

                EXX
                LD HL, (.ScreenAddress)
                EX AF, AF'
                LD (Kernel.LD.NextRow.ScreenAddress), A
                EX AF, AF'
                EXX
                JR .L3

.L2             LD IX, RenderBuffer + SCR_WORLD_SIZE_Y
.L3

                ;RET
                ; LD HL, -4
                ; ADD HL, SP
                ; LD (DrawColumn.ContainerSP), HL
                
                ; -----------------------------------------
                ; чтение адреса из таблицы переходов
                ; -----------------------------------------
                LD HL, (.Table)
                LD A, (HL)
                LD IYL, A
                INC HL
                LD A, (HL)
                LD IYH, A
 
                LD B, SCR_WORLD_SIZE_X-1
                LD A, (.Shift_X)
                OR A
                JR NZ, $+3
                INC B

.ColumnLoop     ;PUSH BC
                LD A, B
                LD (.LLL), A

                CALL DrawColumn
                
                EXX
.ScreenAddress  EQU $+1
                LD HL, #0000
                INC L
                INC L
                LD (.ScreenAddress), HL
                EX AF, AF'
                LD (Kernel.LD.NextRow.ScreenAddress), A
                EX AF, AF'
                EXX
                ;POP BC
.LLL            EQU $+1
                LD B, #00
                DJNZ .ColumnLoop

                LD A, (.Shift_X)
                OR A
                RET Z
                
                LD HL, (.Table)
                INC HL
                INC HL
                
                CP 9
                JR C, $+4
                INC HL
                INC HL

                LD A, (HL)
                LD IYL, A
                INC HL
                LD A, (HL)
                LD IYH, A

                CALL DrawColumn

                RET

                include "Core/Module/Draw/World/DrawColumn.asm"

                display " - Draw World: \t\t\t\t\t", /A, Draw, " = busy [ ", /D, $ - Draw, " bytes  ]"
                endmodule

                endif ; ~ _CORE_MODULE_DRAW_WORLD_DRAW_
