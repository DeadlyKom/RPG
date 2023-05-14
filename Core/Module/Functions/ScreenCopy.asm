
                ifndef _CORE_MODULE_FUNCTIONS_SCREEN_COPY_
                define _CORE_MODULE_FUNCTIONS_SCREEN_COPY_
; -----------------------------------------
; функция копирования в теневой экран
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ShadowScrcpy:   ; копирование в теневой экран
                SetPort PAGE_7, 0                                               ; включить 7 страницу и показать основной экран
                LD HL, MemBank_01_SCR
                LD DE, MemBank_03_SCR
                LD BC, ScreenSize
                JP Memcpy.FastLDIR
; -----------------------------------------
; функция копирования в базовый экран
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
BaseScrcpy:     ; копирование в основной экран
                SetPort PAGE_7, 1                                               ; включить 7 страницу и показать теневой экран
                LD HL, MemBank_03_SCR
                LD DE, MemBank_01_SCR
                LD BC, ScreenSize
                JP Memcpy.FastLDIR

                endif ; ~_CORE_MODULE_FUNCTIONS_SCREEN_COPY_
