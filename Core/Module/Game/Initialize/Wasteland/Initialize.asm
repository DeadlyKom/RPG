
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

                ; установить отсечение отображения пустоши
                SET_CLIP_WASTELAND

                ; инициализаци эффекта
                LD HL, Packs.Wasteland.Render.VFX_Draw
                LD (Packs.Wasteland.Loop.FuncDraw), HL

                ; инициализация главного цикла
                SetGameLoop Packs.Wasteland.Loop

                RET

                endif ; ~_CORE_MODULE_GAME_INITIALIZE_WASTELAND_
