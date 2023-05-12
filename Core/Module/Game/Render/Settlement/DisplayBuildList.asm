
                ifndef _MODULE_GAME_RENDER_SETTLEMENT_DISPLAY_BUILD_LIST_
                define _MODULE_GAME_RENDER_SETTLEMENT_DISPLAY_BUILD_LIST_
COLUMN_BUILD    EQU 7 * 8
ROW_BUILD       EQU 18 * 8
LIST_WIDTH      EQU 24 * 8                                                      ; доступная ширина дял списка (в пикселях)
LIST_HEIGHT     EQU 5 * 8                                                       ; доступная высота дял списка (в пикселях)
HEIGHT_ROW      EQU 9                                                           ; высота строки (в пикселях)
; -----------------------------------------
; отображение списка доступных построек
; In:
;   IX - указывает на структуру FSettlement
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DisplayBuildLst SET_PAGE_OBJECT                                                 ; включить страницу работы с объектами

                ; -----------------------------------------
                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | DC | DY | CL | SH | BR | WS | PR | RT |
                ;   +----+----+----+----+----+----+----+----+
                ;
                ;   EN      [7]     - главный вход, наличие ограждённого периметра
                ;   RA      [6]     - жилой район
                ;   WH      [5]     - склад и сборщик лома
                ;   SH      [4]     - торговый район
                ;   BR      [3]     - бар
                ;   WS      [2]     - мастерская
                ;   PR      [1]     - тюрьма
                ;   RT      [0]     - радио вышка
                ; -----------------------------------------
                LD IY, .Struct
                LD (IY + FDialog.OptionsSize), .OptionsNum

                LD A, (IX + FSettlement.Building)
                LD L, A
                LD H, #FF
                LD (.Available), HL

                LD (IY + FDialog.FirstElement), #06

                LD A, (PlayerState.SettlementLocID)
                LD (IY + FDialog.SkipElement), A

                LD (IY + FDialog.Coord.Y), ROW_BUILD
                LD (IY + FDialog.Size.Height), LIST_HEIGHT
                
                JP Packs.Dialog.Display

.OptionsTable   DW Packs.Text.Build.Entrance
                DW Packs.Text.Build.ResidentialArea
                DW Packs.Text.Build.Worehouse
                DW Packs.Text.Build.ShoppingArea
                DW Packs.Text.Build.Bar
                DW Packs.Text.Build.Workshop
                DW Packs.Text.Build.Priston
                DW Packs.Text.Build.RadioTower
                DW Packs.Text.Options.OpenWorld
.OptionsNum     EQU ($-.OptionsTable) / 2
.Available      DW #0000
.Struct         FDialog {
                .OptionsTable,
                .OptionsNum,
                .Available,
                #00,                                                            ; первый элемент
                #00,                                                            ; пропускаемый элемент
                { COLUMN_BUILD, ROW_BUILD },
                { LIST_WIDTH, LIST_HEIGHT },
                HEIGHT_ROW
                }
.FirstElement   EQU .Struct + FDialog.FirstElement

                endif ; ~_MODULE_GAME_RENDER_SETTLEMENT_DISPLAY_BUILD_LIST_
