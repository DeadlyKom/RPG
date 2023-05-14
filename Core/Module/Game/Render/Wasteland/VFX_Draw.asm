
                ifndef _MODULE_GAME_RENDER_WASTELAND_VFX_DRAW_
                define _MODULE_GAME_RENDER_WASTELAND_VFX_DRAW_
; -----------------------------------------
; отображение пустоши
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
VFX_Draw:       SHOW_BASE_SCREEN                                                ; отобразить основной экран
                HALT                                                            ; ожидание луча
                
                ; отображение надписи "пустошь"
                LD HL, .WastelandText
                LD DE, #5A6A
                CALL Draw.String

                ; копирования в теневой экран
                CALL Func.ShadowScrcpy

                SHOW_SHADOW_SCREEN                                              ; отображение теневого экрана

                ; генерация спрайтов для пустоши
                CALL Execute.WastelandSpr

                ; копирования в базовый экран
                CALL Func.BaseScrcpy

                ; отображение UI пустоши
                CALL UI_Draw

                ; отобразить в теневом экране пустошь
                CALL Draw
                RES_RENDER_FLAG FINISHED_BIT                                    ; сброс флага завершения отрисовки, для эффекта

                ; ожидание
                LD B, #20
.Wait           HALT
                DJNZ .Wait
                
                ; проигрывания эффекта "осветление"
                CALL VFX.Diagonal_In

                ; инициализаци главного рендера пустоши
                LD HL, Packs.Wasteland.Render.Draw
                LD (Packs.Wasteland.Loop.FuncDraw), HL

                RET

.WastelandText  BYTE "Wasteland\0"

                endif ; ~_MODULE_GAME_RENDER_WASTELAND_VFX_DRAW_
