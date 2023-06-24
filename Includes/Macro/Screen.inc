
                ifndef _MACRO_SCREEN_
                define _MACRO_SCREEN_
BORDER          macro Color?
                LD A, Color?
                OUT (#FE), A
                endm

; координаты в пикселях
SCREEN_ADR_REG  macro Register?, ScreenAddress?, X?, Y?
                LD Register?, ScreenAddress? + (((Y? >> 3) & 0x18) << 8) + ((Y? & 0x07) << 8) + ((Y? & 0x38) << 2) + (X? >> 3)
                endm
SCREEN_ATTR_ADR_REG  macro Register?, ScreenAddress?, X?, Y?
                LD Register?, ScreenAddress? | 0x1800 + (((Y? & 0x1F) << 5) + (X? & 0x1F))
                endm
CLS_4000        macro
                LD HL, #4000 + #1800
                LD DE, #0000
                CALL SafeFill.Screen
                endm
ATTR_4000_IP    macro Inc?, Paper?
                LD HL, #4000 + #1800 + #0300
                LD DE, (((Paper? << 3) | Inc?) << 8) | ((Paper? << 3) | Inc?)
                CALL SafeFill.b768
                endm
ATTR_4000_IPB   macro Inc?, Paper?, Bright?
                LD HL, #4000 + #1800 + #0300
                LD DE, ((((0 << 7) | (Bright? << 6) | (Paper? << 3) | Inc?)) << 8) | (((0 << 7) | (Bright? << 6) | (Paper? << 3) | Inc?))
                CALL SafeFill.b768
                endm
ATTR_RECT_IPB   macro ScreenAddress?, X?, Y?, SizeX?, SizeY?, Inc?, Paper?, Bright?
.Address        EQU ScreenAddress? | 0x1800 + (((Y? & 0x1F) << 5) + (X? & 0x1F))
                LD DE, .Address
                LD C, SizeY?
.RowsLoop       LD H, D
                LD L, E
                LD B, SizeX?
.ColumnLoop     LD (HL), ((0 << 7) | (Bright? << 6) | (Paper? << 3) | Inc?)
                INC L
                DJNZ .ColumnLoop
                LD A, E
                ADD A, #20
                LD E, A
                ADC A, D
                SUB E
                LD D, A
                DEC C
                JR NZ, .RowsLoop
                endm
ATTR_C000_IP    macro Inc?, Paper?
                LD HL, #C000 + #1800 + #0300
                LD DE, (((Paper? << 3) | Inc?) << 8) | ((Paper? << 3) | Inc?)
                CALL SafeFill.b768
                endm
ATTR_C000_IPB   macro Inc?, Paper?, Bright?
                LD HL, #C000 + #1800 + #0300
                LD DE, ((((0 << 7) | (Bright? << 6) | (Paper? << 3) | Inc?)) << 8) | (((0 << 7) | (Bright? << 6) | (Paper? << 3) | Inc?))
                CALL SafeFill.b768
                endm
CLS_C000        macro
                LD HL, #C000 + #1800
                LD DE, #0000
                CALL SafeFill.Screen
                endm
ATTR_C000       macro Color?
                LD HL, #C000 + #1800 + #0300
                LD DE, (Color? << 8) | Color?
                CALL SafeFill.b768
                endm
; -----------------------------------------
; расчёт адреса скрытого экрана
; In:
; Out:
;   Reg? - если отображается первый экран равен #С0, иначе #40 
; Corrupt:
;   AF
; Note:
; -----------------------------------------
HiddenScreenAdr macro Reg?
                LD A, (Adr.Port_7FFD)
                AND SCREEN_MASK
                LD Reg?, #C0
                JR Z, $+4
                LD Reg?, #40
                endm
HiddenScreenAdr_ macro Reg?
                LD A, (Adr.Port_7FFD)
                AND SCREEN_MASK
                SET 7, Reg?
                JR Z, $+4
                RES 7, Reg?
                endm
; -----------------------------------------
; корректировка адреса скрытого экрана
; In:
; Out:
;   Reg? - старший байт адреса экрана
; Corrupt:
;   AF
; Note:
; -----------------------------------------
HiddenScrAdr_   macro Reg?
                LD A, (Adr.Port_7FFD)
                AND SCREEN_MASK
                JR Z, $+4
                RES 7, Reg?
                endm
; -----------------------------------------
; корректировка адреса видимого экрана
; In:
;   Reg? - модифицируемый регистр
; Out:
; Corrupt:
;   AF
; Note:
;   после функции PixelAddressP
; -----------------------------------------
VisibleScrAdr_  macro Reg?
                LD A, (Adr.Port_7FFD)
                AND SCREEN_MASK
                JR NZ, $+4
                RES 7, Reg?
                endm
ZX_COLOR_IPBF   macro Inc?, Paper?, Bright?, Flash?
                DB ((Flash? << 7) | (Bright? << 6) | (Paper? << 3) | Inc?)
                endm
ZX_COLOR_IPB    macro Inc?, Paper?, Bright?
                DB ((0 << 7) | (Bright? << 6) | (Paper? << 3) | Inc?)
                endm
ZX_COLOR_IP     macro Inc?, Paper?
                DB ((0 << 7) | (0 << 6) | (Paper? << 3) | Inc?)
                endm
; установка страницы видимого экрана
SET_PAGE_VISIBLE_SCREEN macro
                CALL Screen.SetPageBase
                endm
; установка страницы невидимого экран
SET_PAGE_SHADOW_SCREEN macro
                CALL Screen.SetPageShadow
                endm

; установить отсечение отображения пустоши
SET_CLIP_WASTELAND macro
                LD DE, ((SCR_WASTELAND_POS_Y + (SCR_WASTELAND_SIZE_Y << 1)) << 8)     | SCR_WASTELAND_POS_Y
                LD BC, ((SCR_WASTELAND_POS_X + (SCR_WASTELAND_SIZE_X << 1) - 1) << 8) | SCR_WASTELAND_POS_X
                CALL Utils.ClipRect
                endm
; установить отсечение отображения карты мира
SET_CLIP_MAP    macro
                LD DE, ((SCR_MAP_POS_Y + SCR_MAP_SIZE_Y) << 8) | SCR_MAP_POS_Y
                LD BC, ((SCR_MAP_POS_X + SCR_MAP_SIZE_X) << 8) | SCR_MAP_POS_X
                CALL Utils.ClipRect
                endm

                endif ; ~_MACRO_SCREEN_
