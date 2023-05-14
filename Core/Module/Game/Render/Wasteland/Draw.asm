
                ifndef _MODULE_GAME_RENDER_WASTELAND_DRAW_
                define _MODULE_GAME_RENDER_WASTELAND_DRAW_
; -----------------------------------------
; отображение пустоши
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Draw:           SHOW_SHADOW_SCREEN                                                ; отобразить основной экран

                SET_PAGE_GRAPHICS_1
                LD HL, Graphics.Screen.Test
                LD DE, #4000
                LD BC, 6912
                CALL Memcpy.FastLDIR

                SET_SCREEN_SHADOW
                LD HL, #4000
                LD DE, #E000
                LD BC, 6912
                CALL Memcpy.FastLDIR

                CLS_4000
                ATTR_4000_IPB WHITE, BLACK, 0

                SHOW_BASE_SCREEN                                                ; отобразить основной экран

                LD HL, #E000
                LD DE, #C000
                LD BC, 6912
                CALL Memcpy.FastLDIR

.Processed      ifdef _DEBUG
                CALL FPS_Counter.Frame
                endif
                
                SET_RENDER_FLAG FINISHED_BIT                                    ; установка флага завершения отрисовки
                RET

                endif ; ~_MODULE_GAME_RENDER_WASTELAND_DRAW_
