
                ifndef _MODULE_GAME_RENDER_SETTLEMENT_DISPLAY_BUILD_LIST_
                define _MODULE_GAME_RENDER_SETTLEMENT_DISPLAY_BUILD_LIST_
COLUMN_BUILD    EQU 7
ROW_BUILD       EQU 18
LIST_WIDTH      EQU 24                                                          ; доступная ширина дял списка (в знакоместах)
LIST_HEIGHT     EQU 5                                                           ; доступная высота дял списка (в знакоместах)
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
                LD L, (IX + FSettlement.Building)
                LD H, #FF
                LD (.Available), HL

                ; инициализация структуры диалога
                LD IY, .Struct
                LD (IY + FDialog.OptionsSize), .OptionsNum

                LD A, (GameState.Cursor.Top)
                LD (IY + FDialog.FirstElement), A

                LD A, (PlayerState.SettlementLocID)
                LD (IY + FDialog.SkipElement), A

                LD (IY + FDialog.Coord.Y), ROW_BUILD * 8
                LD (IY + FDialog.Size.Height), LIST_HEIGHT * 8
                
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
                { COLUMN_BUILD * 8, ROW_BUILD * 8 },
                { LIST_WIDTH * 8, LIST_HEIGHT * 8 },
                HEIGHT_ROW
                }

ClearBuildList  SCREEN_ADR_HL #4000, COLUMN_BUILD * 8, ROW_BUILD * 8
                LD C, LIST_HEIGHT * 8
.RowLoop        LD E, L
                XOR A
                LD B, LIST_WIDTH
.Loop           LD (HL), A
                INC L
                DJNZ .Loop

                LD L, E

                ; классический метод "DOWN HL" 25/59
                INC H
                LD A, H
                AND #07
                JP NZ, $+12
                LD A, L
                SUB #E0
                LD L, A
                SBC A, A
                AND #F8
                ADD A, H
                LD H, A

                DEC C
                JR NZ, .RowLoop
                RET

                endif ; ~_MODULE_GAME_RENDER_SETTLEMENT_DISPLAY_BUILD_LIST_
