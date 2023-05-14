
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
                LD DE, #5A68
                CALL Draw.String

                ; копирования в теневой экран
                CALL Func.ShadowScrcpy
                SHOW_SHADOW_SCREEN                                              ; отображение теневого экрана

                ; подготовка пустоши
                CALL Prepare

                ; проигрывания эффекта "осветление"
                CALL VFX.Diagonal_In

                ; инициализаци главного рендера пустоши
                LD HL, Packs.Wasteland.Render.Draw
                LD (Packs.Wasteland.Loop.FuncDraw), HL

                RET

.WastelandText  BYTE "Wasteland\0"

                endif ; ~_MODULE_GAME_RENDER_WASTELAND_VFX_DRAW_
