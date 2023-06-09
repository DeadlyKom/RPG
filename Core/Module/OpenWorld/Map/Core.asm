
                ifndef _CORE_MODULE_OPEN_WORLD_MAP_CORE_
                define _CORE_MODULE_OPEN_WORLD_MAP_CORE_
; -----------------------------------------
; расчёт адреса элемента
; In:
;   BC - положение ячейки (B - x, C - y)
; Out:
;   HL - адрес элемента
; Corrupt:
;   HL, DE, AF
; Note:
; -----------------------------------------
CalcAdrElement: ; позиция по вертикали
                LD A, C
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
                LD A, B
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

                RET
; -----------------------------------------
; получить размер карты (из настроек)
; In:
;   C - размер карты
; Out:
; Corrupt:
; Note:
; -----------------------------------------
GetMapSize:     LD A, (GameState.Setting)
                AND SETTING_MAP_SIZE_MASK
                LD C, MAP_SIZE_SMALL_SQUARED
                RET Z                                                           ; SETTING_MAP_SIZE_SMALL
                LD C, MAP_SIZE_AVERAGE_SQUARED
                CP SETTING_MAP_SIZE_AVERAGE
                RET Z
                LD C, MAP_SIZE_BIG_SQUARED
                RET

                display "\t- Core:\t\t\t\t\t\t", /A, CalcAdrElement, " = busy [ ", /D, $ - CalcAdrElement, " bytes  ]"

                endif ; ~_CORE_MODULE_OPEN_WORLD_MAP_CORE_
