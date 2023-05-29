
                ifndef _CORE_MODULE_GAME_INITIALIZE_MAP_
                define _CORE_MODULE_GAME_INITIALIZE_MAP_
; -----------------------------------------
; инициализация поселения
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Map:            ; установка бордюра
                BORDER BLACK

                ; сброса и уход в затемнение
                CALL Func.ResetFadeout

                ; инициализация главного цикла
                SetGameLoop Packs.Map.Loop

                ; инициализация обработчика прерываний
                SetUserHendler Packs.Map.Interrupt

                ; сброс параметров
                LD HL, PlayerState.Health
                LD DE, PlayerState.Health+1
                LD BC, #09
                LD (HL), #00
                LDIR

                ; подготовка данных карты мира
                SET_PAGE_BLOK_0                                                 ; включение страницы с блоком кода
                CALL Packs.OpenWorld.Map.Prepare

                RET

                endif ; ~_CORE_MODULE_GAME_INITIALIZE_MAP_
