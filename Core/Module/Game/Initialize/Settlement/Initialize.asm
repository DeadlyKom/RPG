
                ifndef _CORE_MODULE_GAME_INITIALIZE_SETTLEMENT_
                define _CORE_MODULE_GAME_INITIALIZE_SETTLEMENT_
; -----------------------------------------
; инициализация поселения
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Settlement:     ; установка бордюра
                BORDER BLACK

                ; инициализация главного цикла
                SetMainLoop Packs.Settlement.Loop

                ; инициализация обработчика прерываний
                SetUserHendler Packs.Settlement.Interrupt

                ; сохранение состояние таблицы генерации
                CALL Math.PushSeed

                RET

                endif ; ~_CORE_MODULE_GAME_INITIALIZE_SETTLEMENT_
