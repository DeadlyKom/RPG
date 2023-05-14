
                ifndef _CORE_MODULE_OPEN_WORLD_WASTELAND_GENERATE_
                define _CORE_MODULE_OPEN_WORLD_WASTELAND_GENERATE_
; -----------------------------------------
; генерация пустоши
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Generate:       SET_PAGE_OBJECT                                                 ; включить страницу работы с объектами

                ; -----------------------------------------
                ; центровка карты мира
                ; -----------------------------------------
                LD B, #01

                ; DEC 32
                LD HL, PlayerState.CameraPosX + 1
                LD A, (HL)
                SUB SCR_MINIMAP_SIZE_X
                LD (HL), A
                JR NC, $+18
                INC L
                LD A, (HL)
                SUB B
                LD (HL), A
                JR NC, $+12
                INC L
                LD A, (HL)
                SUB B
                LD (HL), A
                JR NC, $+6
                INC L
                LD A, (HL)
                SUB B
                LD (HL), A

                ; -----------------------------------------
                ; генерация спрайта мини карты
                ; -----------------------------------------
                LD A, SCR_MINIMAP_SIZE_X

.Loop           PUSH AF
                CALL MoveRight

                ; INC 32
                LD HL, PlayerState.CameraPosX + 1
                INC (HL)
                JR NZ, $+12
                INC L
                INC (HL)
                JR NZ, $+8
                INC L
                INC (HL)
                JR NZ, $+4
                INC L
                INC (HL)

                POP AF
                DEC A
                JR NZ, .Loop
    
                RET

                endif ; ~_CORE_MODULE_OPEN_WORLD_WASTELAND_GENERATE_
