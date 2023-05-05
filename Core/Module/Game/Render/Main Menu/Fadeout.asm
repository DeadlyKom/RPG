
                ifndef _MODULE_GAME_RENDER_MAIN_MENU_FADEOUT_
                define _MODULE_GAME_RENDER_MAIN_MENU_FADEOUT_
; -----------------------------------------
; эффект затемнения
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Fadeout:        LD HL, .Counter
                DEC (HL)
                JR NZ, .Animation

                CLS_4000
                ATTR_4000_IPB WHITE, BLACK, 0

                LD HL, .Counter
                LD (HL), #04
                LD HL, Packs.MainMenu.Render.Draw.MenuType
                RES 0, (HL)
                RET

.Animation      LD HL, #4000
                LD DE, #AA55
                LD BC, #0018
    
                LD A, R
                OR D
                LD D, A

                LD A, R
                OR E
                LD E, A

.Loop           LD A, D
                LD D, E
                LD E, A
            
.LoopRow        LD A, (HL)
                AND E
                LD (HL), A
                INC HL
                DJNZ .LoopRow

                DEC C
                JR NZ, .Loop

                RET
.Counter        DB #04

                endif ; ~_MODULE_GAME_RENDER_MAIN_MENU_FADEOUT_
