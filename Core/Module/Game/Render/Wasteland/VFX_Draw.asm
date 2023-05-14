
                ifndef _MODULE_GAME_RENDER_WASTELAND_VFX_DRAW_
                define _MODULE_GAME_RENDER_WASTELAND_VFX_DRAW_
; -----------------------------------------
; отображение пустоши
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
VFX_Draw:       ; отобразить в теневом экране пустошь
                SHOW_BASE_SCREEN                                                ; отобразить основной экран
                HALT
                CALL Draw
                RES_RENDER_FLAG FINISHED_BIT                                    ; сброс флага завершения отрисовки, для эффекта
                HALT                                                            ; ожидание луча

                ; отображение надписи "пустошь"
                LD HL, .WastelandText
                LD DE, #5A6A
                CALL Draw.String

                ; проверка флага проигрывания эффекта "осветление"
                CHECK_MENU_FLAG MENU_FADEIN_BIT
                JR Z, .Complete
                RES_FLAG MENU_FADEIN_BIT                                        ; сброс флага эфекта перехода

                LD B, #38
.Wait           HALT
                DJNZ .Wait
                
                ; проигрывания эффекта "осветление"
                CALL VFX.Diagonal_In

.Complete       ; инициализаци главного рендера пустоши
                LD HL, Packs.Wasteland.Render.Draw
                LD (Packs.Wasteland.Loop.FuncDraw), HL
                RET

.WastelandText  BYTE "Wasteland\0"

                endif ; ~_MODULE_GAME_RENDER_WASTELAND_VFX_DRAW_
