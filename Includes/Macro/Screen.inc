
                ifndef _MACRO_SCREEN_
                define _MACRO_SCREEN_
BORDER          macro Color?
                LD A, Color?
                OUT (#FE), A
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
                INC HL
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
                LD A, (MemoryPageRef)
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

                endif ; ~_MACRO_SCREEN_