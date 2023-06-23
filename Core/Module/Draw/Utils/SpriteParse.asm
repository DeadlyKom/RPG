
                ifndef _CORE_MODULE_DRAW_UTILS_SPRITE_PARSE_
                define _CORE_MODULE_DRAW_UTILS_SPRITE_PARSE_

                module Utils
; -----------------------------------------
; парсинг структуры спрайта
; In:
;   HL - адрес структуры спрайта FSprite
; Out:
;   HL - адрес спрайта
; Corrupt:
;   HL, DE, BC, AF
; Note:
;   включена страница спрайта
; -----------------------------------------
SpriteParse:    ; -----------------------------------------
                ; чтение информации о спрайте
                ; -----------------------------------------
                LD E, (HL)                                                      ; FSprite.Info.Height
                INC HL
                LD A, (HL)                                                      ; FSprite.Info.OffsetY
                LD (Draw.Prepare.SOy), A
                INC HL
                LD D, (HL)                                                      ; FSprite.Info.Width
                LD (Draw.Prepare.Size), DE
                INC HL
                LD A, (HL)                                                      ; FSprite.Info.OffsetX
                LD (Draw.Prepare.SOx), A
                INC HL
                LD A, (HL)                                                      ; FSprite.Offset
                INC HL
                LD (GameConfig.SpriteOffsetRef), A
                LD A, (HL)                                                      ; FSprite.Page
                INC HL
                LD E, CSIF_OR_XOR << 1
                ADD A, A
                RR E
                RRA
                CALL SetPage
                LD A, E
                LD (GameConfig.SpriteFlagRef), A
                LD E, (HL)                                                      ; FSprite.Data.Low
                INC HL
                LD D, (HL)                                                      ; FSprite.Data.High
                EX DE, HL
                
                RET

                display " - Sprite parse: \t\t\t\t\t", /A, SpriteParse, " = busy [ ", /D, $ - SpriteParse, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_DRAW_UTILS_SPRITE_PARSE_
