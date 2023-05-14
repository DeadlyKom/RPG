
                ifndef _CORE_MODULE_GAME_INITIALIZE_WASTELAND_
                define _CORE_MODULE_GAME_INITIALIZE_WASTELAND_
; -----------------------------------------
; инициализация пустоши
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Wasteland:      ; установка бордюра
                BORDER BLACK

                ; сброса и уход в затемнение
                CALL Func.ResetFadeout

                ; инициализация главного цикла
                SetGameLoop Packs.Wasteland.Loop

                ; инициализация обработчика прерываний
                SetUserHendler Packs.Wasteland.Interrupt

                RET

                endif ; ~_CORE_MODULE_GAME_INITIALIZE_WASTELAND_
