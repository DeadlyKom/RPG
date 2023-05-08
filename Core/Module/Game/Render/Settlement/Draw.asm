
                ifndef _MODULE_GAME_RENDER_SETTLEMENT_DRAW_
                define _MODULE_GAME_RENDER_SETTLEMENT_DRAW_
; -----------------------------------------
; отображение поселение
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Draw:           ; счётчик отображаемого экрана
                LD HL, .Counter
                LD A, (HL)
                INC (HL)
                RRA
                JR NC, .BaseDraw

.ShadowDraw     SetPort PAGE_7, 0                                               ; включить 7 страницу и показать основной экран
                LD HL, MemBank_01_SCR
                LD DE, MemBank_03_SCR
                LD BC, ScreenSize
                CALL Memcpy.FastLDIR
                JR .Processed
                
.BaseDraw       SetPort PAGE_6, 1                                               ; включить 6 страницу и показать теневой экран
; .MenuType       EQU $+1
;                 LD A, MENU_TYPE_MAIN
;                 SRL A
;                 JP C, Fadeout
;                 CP MENU_TYPE_MAIN >> 1
;                 CALL Z, Main
;                 CP MENU_TYPE_CONTINUE >> 1
;                 CALL Z, Continue
;                 CP MENU_TYPE_OPTIONS >> 1
;                 CALL Z, Options
;                 CP MENU_TYPE_REDEFINE >> 1
;                 CALL Z, RedefineKeys

.Processed      ifdef _DEBUG
                CALL FPS_Counter.Frame
                endif

                SET_RENDER_FLAG FINISHED_BIT                                    ; установка флага завершения отрисовки
                RET

.Counter        DB #00

                endif ; ~_MODULE_GAME_RENDER_SETTLEMENT_DRAW_
