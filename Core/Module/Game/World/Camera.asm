
                ifndef _MODULE_GAME_WORLD_CAMERA_
                define _MODULE_GAME_WORLD_CAMERA_
; -----------------------------------------
; расчёт дельт слежения за игроком
; In:
;   IX - адрес FObject игрока
; Out:
; Corrupt:
; Note:
; ----------------------------------------
Camera:         ;
                LD HL, (IX + FObject.Position.X)
                ADD HL, HL
                LD A, H
                SUB SCR_CAMERA_CENTER_X + SCR_WORLD_POS_X
                LD (PlayerState.DeltaCameraX), A

                ;
                LD HL, (IX + FObject.Position.Y)
                ADD HL, HL
                LD A, H
                SUB SCR_CAMERA_CENTER_Y + SCR_WORLD_POS_Y+1
                LD (PlayerState.DeltaCameraY), A

                RET

; -----------------------------------------
; горизонтальный лерп камеры
; In:
;   IX - адрес FObject игрока
; Out:
; Corrupt:
; Note:
; ----------------------------------------
Horizontal:     ; скорость
                LD A, (PlayerState.Speed)
                OR A
                JP P, $+5
                NEG

                RRA
                RRA
                AND %001111
                INC A
                LD B, A
                LD HL, #0200
                LD DE, #0002
.MultLoop       ADD HL, DE
                DJNZ .MultLoop
                EX DE, HL

                LD A, (PlayerState.DeltaCameraX)
                BIT 7, A
                JR NZ, .IsNegative

                ; const float Dist = Target - Current;
                ; if( FMath::Square(Dist) < SMALL_NUMBER )
                ; {
                ;     return Target;
                ; }
                ; const float DeltaMove = Dist * FMath::Clamp<float>(DeltaTime * InterpSpeed, 0.f, 1.f);
                ; return Current + DeltaMove;

                ; ----------------------------------------
                ; In:
                ;   DE - multiplicand
                ;   A  - multiplier
                ; Out :
                ;   HL - product DE * A
                ; Corrupt :
                ;   HL, F
                ; ----------------------------------------
                CALL Math.Mul16x8_16

                LD A, H
                NEG
                LD (PlayerState.DeltaCameraPixX), A

                LD A, H
                ADD A, A
                ADD A, A
                ADD A, A
                LD D, A

                AND #F0
                LD HL, PlayerState.CameraPosX
                ADD A, (HL)
                LD (HL), A
                LD E, A
                JR NC, .LL1
                INC L
                INC (HL)
                JR NZ, .LL2
                INC L
                INC (HL)
                JR NZ, .LL2
                INC L
                INC (HL)
                JR NZ, .LL2
                INC L
                INC (HL)
.LL2            SET_WORLD_FLAG WORLD_RIGHT_BIT

.LL1            LD A, E
                RRA
                RRA
                RRA
                RRA
                AND #0E
                LD (World.Shift_X), A

                SET_PAGE_OBJECT                                                 ; включить страницу работы с объектами
                LD IX, PLAYER_ADR
                LD HL, (IX + FObject.Position.X)

                ; LD A, D
                ; BIT 3, A
                ; JR Z, $+4
                ; SUB #10
                ; LD E, A
                ; LD D, #00

                LD E, D
                LD D, #00

                OR A
                SBC HL, DE
                LD (IX + FObject.Position.X), HL
                SET_SCREEN_SHADOW                                               ; включение страницы второго экрана
                RET

.IsNegative     NEG

                ; ----------------------------------------
                ; In:
                ;   DE - multiplicand
                ;   A  - multiplier
                ; Out :
                ;   HL - product DE * A
                ; Corrupt :
                ;   HL, F
                ; ----------------------------------------
                CALL Math.Mul16x8_16

                LD A, H
                LD (PlayerState.DeltaCameraPixX), A
                ADD A, A
                ADD A, A
                ADD A, A
                LD D, A

                AND #F0
                LD C, A
                LD HL, PlayerState.CameraPosX
                LD A, (HL)
                SUB C
                LD (HL), A
                LD E, A
                JR NC, .LL1_
                INC L
                LD A, (HL)
                SUB #01
                LD (HL), A
                JR NC, .LL2_
                INC L
                LD A, (HL)
                SUB #01
                LD (HL), A
                JR NC, .LL2_
                INC L
                LD A, (HL)
                SUB #01
                LD (HL), A
                JR NC, .LL2_
                INC L
                LD A, (HL)
                SUB #01
                LD (HL), A
.LL2_           SET_WORLD_FLAG WORLD_LEFT_BIT

.LL1_           LD A, E
                RRA
                RRA
                RRA
                RRA
                AND #0E
                LD (World.Shift_X), A

                SET_PAGE_OBJECT                                                 ; включить страницу работы с объектами
                LD IX, PLAYER_ADR
                LD HL, (IX + FObject.Position.X)
                
                ; LD A, D
                ; BIT 3, A
                ; JR Z, $+4
                ; ADD A, #10
                ; LD E, A
                ; LD D, #00

                LD E, D
                LD D, #00

                ADD HL, DE
                LD (IX + FObject.Position.X), HL
                SET_SCREEN_SHADOW                                               ; включение страницы второго экрана

                RET
Vertical:       ; скорость
                LD A, (PlayerState.Speed)
                OR A
                JP P, $+5
                NEG

                RRA
                RRA
                AND %001111
                INC A
                LD B, A
                LD HL, #0200
                LD DE, #0002

.MultLoop       ADD HL, DE
                DJNZ .MultLoop

                EX DE, HL

                LD A, (PlayerState.DeltaCameraY)
                BIT 7, A
                JR NZ, .IsNegative
                ; NEG

                ; const float Dist = Target - Current;
                ; if( FMath::Square(Dist) < SMALL_NUMBER )
                ; {
                ;     return Target;
                ; }
                ; const float DeltaMove = Dist * FMath::Clamp<float>(DeltaTime * InterpSpeed, 0.f, 1.f);
                ; return Current + DeltaMove;

                ; ----------------------------------------
                ; In:
                ;   DE - multiplicand
                ;   A  - multiplier
                ; Out :
                ;   HL - product DE * A
                ; Corrupt :
                ;   HL, F
                ; ----------------------------------------
                CALL Math.Mul16x8_16

                LD A, H
                NEG
                LD (PlayerState.DeltaCameraPixY), A
                
                LD A, H
                ADD A, A
                ADD A, A
                ADD A, A
                LD D, A

                AND #F0
                ; INC 40 (8)
                LD C, A
                LD HL, PlayerState.CameraPosY
                LD A, (HL)
                SUB C
                LD (HL), A
                LD E, A
                JR NC, .LL1
                INC L
                INC (HL)
                JR NZ, .LL2
                INC L
                INC (HL)
                JR NZ, .LL2
                INC L
                INC (HL)
                JR NZ, .LL2
                INC L
                INC (HL)
.LL2            SET_WORLD_FLAG WORLD_DOWN_BIT

.LL1            LD A, E
                RRA
                RRA
                RRA
                RRA
                AND #0E
                LD (World.Shift_Y), A

                SET_PAGE_OBJECT                                                 ; включить страницу работы с объектами
                LD IX, PLAYER_ADR
                LD HL, (IX + FObject.Position.Y)
                OR A
                LD E, D
                LD D, #00
                SBC HL, DE
                LD (IX + FObject.Position.Y), HL
                SET_SCREEN_SHADOW                                               ; включение страницы второго экрана

                RET

.IsNegative     NEG; ----------------------------------------
                ; In:
                ;   DE - multiplicand
                ;   A  - multiplier
                ; Out :
                ;   HL - product DE * A
                ; Corrupt :
                ;   HL, F
                ; ----------------------------------------
                CALL Math.Mul16x8_16

                LD A, H
                LD (PlayerState.DeltaCameraPixY), A
                ADD A, A
                ADD A, A
                ADD A, A
                LD D, A

                AND #F0
                ; DEC 40 (8)
                LD HL, PlayerState.CameraPosY
                ADD A, (HL)
                LD (HL), A
                LD E, A
                JR NC, .LL1_
                INC L
                LD A, (HL)
                SUB #01
                LD (HL), A
                JR NC, .LL2_
                INC L
                LD A, (HL)
                SUB #01
                LD (HL), A
                JR NC, .LL2_
                INC L
                LD A, (HL)
                SUB #01
                LD (HL), A
                JR NC, .LL2_
                INC L
                LD A, (HL)
                SUB #01
                LD (HL), A
.LL2_           SET_WORLD_FLAG WORLD_UP_BIT

.LL1_           LD A, E
                RRA
                RRA
                RRA
                RRA
                AND #0E
                LD (World.Shift_Y), A

                SET_PAGE_OBJECT                                                 ; включить страницу работы с объектами
                LD IX, PLAYER_ADR
                LD HL, (IX + FObject.Position.Y)
                OR A
                LD E, D
                LD D, #00
                ADD HL, DE
                LD (IX + FObject.Position.Y), HL
                SET_SCREEN_SHADOW                                               ; включение страницы второго экрана

                RET

                endif ; ~_MODULE_GAME_WORLD_CAMERA_
