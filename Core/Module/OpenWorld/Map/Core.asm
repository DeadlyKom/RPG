
                ifndef _CORE_MODULE_OPEN_WORLD_MAP_CORE_
                define _CORE_MODULE_OPEN_WORLD_MAP_CORE_
; -----------------------------------------
; установка значения в буфере
; In:
;   IX - адрес структуры FVoronoiDiagram
; Out:
; Corrupt:
; Note:
; -----------------------------------------
SetValue:       ; позиция по вертикали
                LD B, (IX + FVoronoiDiagram.Y)
                LD A, B
                AND VORONOI_DIAGRAM_POS_MASK

                ; Y * 72
                ADD A, A        ; x2
                LD L, A
                LD H, #00
                ADD HL, HL      ; x4
                ADD HL, HL      ; x8
                LD D, H
                LD E, L
                ADD HL, HL      ; x16
                ADD HL, HL      ; x32
                ADD HL, HL      ; x64
                ADD HL, DE      ; x72

                ; позиция по горизонтали
                LD C, (IX + FVoronoiDiagram.X)
                LD A, C
                AND VORONOI_DIAGRAM_POS_MASK

                ; Y * 72 + X
                LD E, A
                LD D, #00
                ADD HL, DE

                ; (Y * 72 + X) * 3
                LD D, H
                LD E, L
                ADD HL, HL      ; x2
                ADD HL, DE      ; x3

                ; установка 3 банка памяти
                LD A, H
                OR %11000000
                LD H, A

                ; установка значения
                LD (HL), C
                INC HL
                LD (HL), B
                INC HL
                LD A, (IY + FVoronoiDiagram.Data)
                LD (HL), A

                RET

                display "\t- Core:\t\t\t\t\t\t", /A, SetValue, " = busy [ ", /D, $ - SetValue, " bytes  ]"

                endif ; ~_CORE_MODULE_OPEN_WORLD_MAP_CORE_
