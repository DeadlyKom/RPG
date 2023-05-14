
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

                ; копирование в теневой экран
                ; идёт следом

                endif ; ~_CORE_MODULE_FUNCTIONS_RESET_FADEOUT_
