
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
                
.BaseDraw       SetPort PAGE_0, 1                                               ; включить 6 страницу и показать теневой экран

                ; получение имени поселения
                LD A, (PlayerState.SettlementID)
                CALL Packs.OpenWorld.Utils.GetSettlement
                CALL Packs.OpenWorld.Utils.GetSettleName

                SET_PAGE_INITIALIZE                                             ; включить страницу работы с инициализациями
                
                LD HL, Adr.SortBuffer
                LD DE, #1A10
                CALL Packs.DrawString

.Processed      ifdef _DEBUG
                CALL FPS_Counter.Frame
                endif

                SET_RENDER_FLAG FINISHED_BIT                                    ; установка флага завершения отрисовки
                RET

.Counter        DB #00

                endif ; ~_MODULE_GAME_RENDER_SETTLEMENT_DRAW_
