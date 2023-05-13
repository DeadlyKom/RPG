
                ifndef _MODULE_GAME_RENDER_SETTLEMENT_DISPLAY_SCROLL_
                define _MODULE_GAME_RENDER_SETTLEMENT_DISPLAY_SCROLL_
COLUMN_SCROLL   EQU 31
ROW_SCROLL      EQU 18
SCROLL_WIDTH    EQU 1                                                           ; доступная ширина дял списка (в знакоместах)
SCROLL_HEIGHT   EQU 5                                                           ; доступная высота дял списка (в знакоместах)
; -----------------------------------------
; отображение скрола доступных построек
; In:
;   IX - указывает на структуру FSettlement
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DisplayScroll   SET_PAGE_OBJECT                                                 ; включить страницу работы с объектами
                
                ; инициализация структуры диалога
                LD IY, .Struct

                LD A, (GameState.Cursor.Num)
                LD (IY + FDialog.OptionsSize), A

                LD A, (GameState.CursorID+2)
                LD (IY + FDialog.FirstElement), A

                LD (IY + FDialog.Coord.Y), ROW_SCROLL * 8 - 4
 
                JP Packs.Dialog.Scroll

.Struct         FDialog {
                #0000,
                #00,
                #0000,
                #00,                                                            ; текущий элемент
                #00,                                                            ; пропускаемый элемент
                { COLUMN_SCROLL * 8, ROW_SCROLL * 8 - 4},
                { SCROLL_WIDTH, SCROLL_HEIGHT },
                HEIGHT_ROW
                }
ClearScroll     SCREEN_ADR_HL #4000, COLUMN_SCROLL * 8, ROW_SCROLL * 8 - 4
                LD BC, (SCROLL_WIDTH << 8) | SCROLL_HEIGHT * 8 + 6
                JP ClearBlock

                endif ; ~_MODULE_GAME_RENDER_SETTLEMENT_DISPLAY_SCROLL_
