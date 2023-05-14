
                ifndef _CORE_MODULE_FUNCTIONS_RESET_FADEOUT_
                define _CORE_MODULE_FUNCTIONS_RESET_FADEOUT_
; -----------------------------------------
; функция сброса и уход в затемнение
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
ResetFadeout:   ; инициализация главного цикла (откл)
                ResGameLoop

                ; инициализация обработчика прерываний (откл)
                ResUserHendler

                ; затемнение и очистка экрана
                CALL VFX.Diagonal_Out

                ; очистка основного окна
                CLS_4000
                ATTR_4000_IPB WHITE, BLACK, 0

                ; очистка теневого окна
                SetPort PAGE_7, 0                                               ; включить 7 страницу и показать основной экран
                LD HL, MemBank_01_SCR
                LD DE, MemBank_03_SCR
                LD BC, ScreenSize
                JP Memcpy.FastLDIR

                endif ; ~_CORE_MODULE_FUNCTIONS_RESET_FADEOUT_
