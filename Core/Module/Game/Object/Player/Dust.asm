
                ifndef _MODULE_GAME_OBJECT_PLAYER_DUST_
                define _MODULE_GAME_OBJECT_PLAYER_DUST_
; -----------------------------------------
; спавн пыли от колёс
; In:
;   IX - адрес обрабатываемого объекта FObject
; Out:
; Corrupt:
; Note:
; ----------------------------------------
Dust:           ;CHECK_PLAYER_FLAG TURBOCHARGING_BIT
                LD A, (PlayerState.Speed)
                ; JR NZ, .Turbocharging

                CP #04
                RET C

;                 CP #20
;                 RET NC

; .Turbocharging  CP #38
;                 RET NC

.L1             EQU $+1
                LD A, #04
                DEC A
                JR NZ, .L2

                ; -----------------------------------------
                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | .. | B3 | B2 | B1 | B0 | .. | .. | .. |
                ;   +----+----+----+----+----+----+----+----+
                ;
                ;   B3-B0   [6..3]  - направление
                ;                       0000 - 0.0°     right
                ;                       0001 - 22.5°
                ;                       0010 - 45.0°    up-right
                ;                       0011 - 67.5°
                ;                       0100 - 90.0°    up
                ;                       0101 - 112.5°
                ;                       0110 - 135.0°   up-left
                ;                       0111 - 157.5°
                ;                       1000 - 180.0°   left
                ;                       1001 - 202.5°
                ;                       1010 - 225.0°   down-left
                ;                       1011 - 247.0°
                ;                       1100 - 270.0°   down
                ;                       1101 - 292.5°
                ;                       1110 - 315.0°   down-right
                ;                       1111 - 337.5°
                ; -----------------------------------------
                
                LD A, (IX + FObject.Direction)
                RRA
                RRA
                AND %00011110
                ADD A, LOW .Table
                LD L, A
                ADC A, HIGH .Table
                SUB L
                LD H, A

                ;
                LD E, (HL)
                INC HL
                LD D, (HL)

                ; спавн частиц пыли от колёс
                LD BC, (PARTICLE_DUST << 8) | OBJECT_PARTICLE
                CALL Func.SpawnObject

                LD HL, (IY + FObject.Velocity.X)
                XOR A
                SUB L
                LD L, A
                SBC A, A
                SUB H
                LD H, A
                LD L, H

                rept 3
                SRA H
                RR L
                endr

                LD (IY + FObjectParticle.Velocity.X), HL
                LD HL, (IY + FObject.Velocity.Y)
                ; XOR A
                ; SUB L
                ; LD L, A
                ; SBC A, A
                ; SUB H
                ; LD H, A

                rept 3
                SRA H
                RR L
                endr

                LD (IY + FObjectParticle.Velocity.Y), HL

                LD A, #04
.L2             LD (.L1), A

                RET

.Table          DW ((6)  & 0xFF) << 8 | ((-4) & 0xFF)                           ; 0000 - 0.0°     right
                DW ((10) & 0xFF) << 8 | ((-6) & 0xFF)                           ; 0001 - 22.5°
                DW ((14) & 0xFF) << 8 | ((-2) & 0xFF)                           ; 0010 - 45.0°    up-right
                DW ((15) & 0xFF) << 8 | ((2)  & 0xFF)                           ; 0011 - 67.5°
                DW ((16) & 0xFF) << 8 | ((8)  & 0xFF)                           ; 0100 - 90.0°    up
                DW ((16) & 0xFF) << 8 | ((14) & 0xFF)                           ; 0101 - 112.5°
                DW ((16) & 0xFF) << 8 | ((16) & 0xFF)                           ; 0110 - 135.0°   up-left
                DW ((14) & 0xFF) << 8 | ((20) & 0xFF)                           ; 0111 - 157.5°
                DW ((6)  & 0xFF) << 8 | ((22) & 0xFF)                           ; 1000 - 180.0°   left
                DW ((2)  & 0xFF) << 8 | ((20) & 0xFF)                           ; 1001 - 202.5°
                DW ((-1) & 0xFF) << 8 | ((18) & 0xFF)                           ; 1010 - 225.0°   down-left
                DW ((-3) & 0xFF) << 8 | ((14) & 0xFF)                           ; 1011 - 247.0°
                DW ((-5) & 0xFF) << 8 | ((7)  & 0xFF)                           ; 1100 - 270.0°   down
                DW ((-3) & 0xFF) << 8 | ((3)  & 0xFF)                           ; 1101 - 292.5°
                DW ((0)  & 0xFF) << 8 | ((0)  & 0xFF)                           ; 1110 - 315.0°   down-right
                DW ((1)  & 0xFF) << 8 | ((-2) & 0xFF)                           ; 1111 - 337.5°

                endif ; ~_MODULE_GAME_OBJECT_PLAYER_DUST_
