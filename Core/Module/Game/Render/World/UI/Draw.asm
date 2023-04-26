
                ifndef _MODULE_GAME_RENDER_UI_DRAW_
                define _MODULE_GAME_RENDER_UI_DRAW_
; -----------------------------------------
; отображение/обновление UI карты мира
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Draw:           LD DE, #0101
                LD BC, .Test1
                LD A, (.Dir1)
                ADD A, A
                CALL NC, IncBar
                LD A, (.Dir1)
                ADD A, A
                CALL C, DecBar

                LD DE, #0802
                LD BC, .Test2
                LD A, (.Dir2)
                ADD A, A
                CALL NC, IncBar
                LD A, (.Dir2)
                ADD A, A
                CALL C, DecBar

                LD DE, #0503
                LD BC, .Test3
                LD A, (.Dir3)
                ADD A, A
                CALL NC, IncBar
                LD A, (.Dir3)
                ADD A, A
                CALL C, DecBar

                LD A, (.Test1)
                LD BC, #2CFF
                CP #FF
                JR Z, .L1
                LD BC, #0000
                CP #00
                JR Z, .L1
                JR .L2
.L1             LD A, C
                LD (.Dir1), A
                LD A, B
                LD (.Test1+1), A

.L2             LD A, (.Test2)
                LD BC, #2CFF
                CP #FF
                JR Z, .L3
                LD BC, #0000
                CP #00
                JR Z, .L3
                JR .L4
.L3             LD A, C
                LD (.Dir2), A
                LD A, B
                LD (.Test2+1), A

.L4             LD A, (.Test3)
                LD BC, #2CFF
                CP #FF
                JR Z, .L5
                LD BC, #0000
                CP #00
                JR Z, .L5
                RET
.L5             LD A, C
                LD (.Dir3), A
                LD A, B
                LD (.Test3+1), A
                RET

.Test1          DW #0000
.Dir1           DB #00
.Test2          DW #0000
.Dir2           DB #00
.Test3          DW #0000
.Dir3           DB #00

                endif ; ~_MODULE_GAME_RENDER_UI_DRAW_
