
                ifndef _MACRO_MEMORY_
                define _MACRO_MEMORY_
; -----------------------------------------
; включение страницы памяти в банк 03
; In:
; Out:
; Corrupt:
;   BC, AF
; -----------------------------------------
SetPage:        macro Page?
                LD BC, Adr.Port_7FFD
                LD A, (BC)
                AND PAGE_MASK_INV
                OR Page?
                LD (BC), A
                OUT (C), A
                endm
SetPort:        macro Page?, Screen?
                LD BC, Adr.Port_7FFD
                LD A, (BC)
                AND ~(SCREEN_MASK | PAGE_MASK)
                OR Page? | (Screen? << SCREEN_BIT)
                LD (BC), A
                OUT (C), A
                endm
; включение страницы масива объектов
SET_PAGE_OBJECT macro
                CALL SetPage0
                endm
SET_PAGE_BLOK_0 macro
                CALL SetPage0
                endm
; -----------------------------------------
; включение страницы с графикой
; -----------------------------------------
SET_PAGE_GRAPHICS_1 macro 
                CALL SetPage3
                endm
; -----------------------------------------
; включение страницы с главным меню
; -----------------------------------------
SET_PAGE_MAIN_MENU macro 
                CALL SetPage6
                endm
; -----------------------------------------
; включение страницы с блоком кода
; -----------------------------------------
SET_PAGE_BLOK_6 macro 
                CALL SetPage6
                endm
; -----------------------------------------
; включение страницы первого экрана
; -----------------------------------------
SET_SCREEN_BASE macro
                CALL SetPage5
                endm
; -----------------------------------------
; включение страницы второго экрана
; -----------------------------------------
SET_SCREEN_SHADOW macro
                CALL SetPage7
                endm
; -----------------------------------------
; включить экран находящийся в 3 банке (5 или 7 страница)
; -----------------------------------------
SET_SCREEN_C000 macro
                CALL Screen.FromPageC000
                endm
; -----------------------------------------
; переключение страницы экрана
; -----------------------------------------
SWAP_SCREEN     macro
                CALL Screen.Swap
                endm
; -----------------------------------------
; отображение базового экрана
; -----------------------------------------
SHOW_BASE_SCREEN macro
                CALL Screen.ShowBase
                endm
; -----------------------------------------
; отображение теневого экрана
; -----------------------------------------
SHOW_SHADOW_SCREEN macro
                CALL Screen.ShowShadow
                endm
; -----------------------------------------
; включение страниц
; -----------------------------------------
SET_PAGE_0      macro
                CALL SetPage0
                endm
SET_PAGE_1      macro
                CALL SetPage1
                endm
SET_PAGE_2      macro
                CALL SetPage2
                endm
SET_PAGE_3      macro
                CALL SetPage3
                endm
SET_PAGE_4      macro
                CALL SetPage4
                endm
SET_PAGE_5      macro
                CALL SetPage5
                endm
SET_PAGE_6      macro
                CALL SetPage6
                endm
SET_PAGE_7      macro
                CALL SetPage7
                endm

                endif ; ~_MACRO_MEMORY_
