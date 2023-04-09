
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
                CP SCR_CAMERA_LEFT_EDGE
                ; RET C

                ; дельта по горизонтали
                SUB SCR_WORLD_POS_X
                LD (PlayerState.DeltaCameraX), A
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
                RRA
                RRA
                AND %001110
                INC A
                LD B, A
                LD HL, #0080
                LD DE, #0004
.LLLLL          ADD HL, DE
                DJNZ .LLLLL
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
                ; LD DE, #0040
                CALL Math.Mul16x8_16

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
.LL2
                SET_WORLD_FLAG WORLD_RIGHT_BIT
.LL1

                LD A, E
                RRA
                RRA
                RRA
                RRA
                AND #0E
                LD (World.Shift_X), A

                SET_PAGE_OBJECT                                                 ; включить страницу работы с объектами
                LD IX, #C000
                LD HL, (IX + FObject.Position.X)
                OR A
                LD E, D
                LD D, #00
                SBC HL, DE
                LD (IX + FObject.Position.X), HL
                SET_SCREEN_SHADOW                                               ; включение страницы второго экрана
                RET

.IsNegative     NEG
                RET

                endif ; ~_MODULE_GAME_WORLD_CAMERA_
