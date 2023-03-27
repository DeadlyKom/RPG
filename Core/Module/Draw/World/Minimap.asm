
                ifndef _CORE_MODULE_DRAW_WORLD_DRAW_MINIMAP_
                define _CORE_MODULE_DRAW_WORLD_DRAW_MINIMAP_

                module World
; -----------------------------------------
; отображение миникарты
; In:
; Out:
; Corrupt:
; Note:
;   установить RestoreBC
;   установить 7 страницу
;   устойчивый к прерываниям
; -----------------------------------------
Minimap:        ; -----------------------------------------
                ; инициализация
                ; -----------------------------------------
                LD (.ContainerSP), SP
                LD HL, Adr.MinimapSpr

                ; -----------------------------------------
                ; защита от повреждения данных во время прерывания
                ; -----------------------------------------
                ; копирование данных 2-х байт спрайта
                LD C, (HL)
                INC L
                LD B, (HL)
                INC L

                ; инициализация стека, указывает на спрайт тайла
                LD SP, HL

                LD HL, .ScrAdr
                HiddenScrAdr_ H                                                 ; корректировка адреса скрытого экрана

                ; HL - хранит экранный адрес вывода
                LD D, H
                LD E, L

                ; -----------------------------------------
                ; отрисовка первой строки спрайта
                ; -----------------------------------------
                LD (HL), C
                INC L
                LD (HL), B
                INC L
                POP BC
                LD (HL), C
                INC L
                LD (HL), B
                
                INC H
                LD L, E

                LD A, #07
                EX AF, AF'
                LD A, #04
.Loop           EX AF, AF'
.RowsLoop       ; -----------------------------------------
                ; отрисовка строки спрайта
                ; -----------------------------------------
                POP BC
                LD (HL), C
                INC L
                LD (HL), B
                INC L
                POP BC
                LD (HL), C
                INC L
                LD (HL), B

.NextRow        INC H
                LD L, E

                DEC A
                JR NZ, .RowsLoop
                
                ; следующее знакоместо
                LD A, L
                ADD A, #20
                LD L, A
                LD E, L
                LD H, D
                
                LD A, #08
                EX AF, AF'
                DEC A
                JR NZ, .Loop

.ContainerSP    EQU $+1
                LD SP, #0000

                RET

                ; заранее расчитаный адрес положения мини карты на экране
.ScrAdr         EQU MemBank_03_SCR | (((SCR_MINIMAP_POS_PIX_Y >> 3) & 0x18) << 8) + ((SCR_MINIMAP_POS_PIX_Y & 0x07) << 8) + ((SCR_MINIMAP_POS_PIX_Y & 0x38) << 2) + SCR_MINIMAP_POS_X

                display " - Draw minimap : \t\t\t\t\t", /A, Minimap, " = busy [ ", /D, $ - Minimap, " bytes  ]"

                endmodule
 
                endif ; ~_MODULE_G_CORE_MODULE_DRAW_WORLD_DRAW_MINIMAP_AME_RENDER_MINIMAP_
