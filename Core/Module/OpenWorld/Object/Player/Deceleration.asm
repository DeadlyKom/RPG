
                ifndef _CORE_MODULE_OPEN_WORLD_OBJECT_PLAYER_DECELERATION_
                define _CORE_MODULE_OPEN_WORLD_OBJECT_PLAYER_DECELERATION_
; -----------------------------------------
; пассивное торможение игрока
; In:
;   IX - адрес обрабатываемого объекта FObject
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Deceleration:   
.Movement       LD HL, (IX + FObject.Velocity.X)
                PUSH HL

                rept 3
                SRA H
                RR L
                endr

                ; NEG HL
                XOR A
                SUB L
                LD L, A
                SBC A, A
                SUB H
                LD H, A
                POP DE
                ADD HL, DE
                LD (IX + FObject.Velocity.X), HL

                LD HL, (IX + FObject.Velocity.Y)
                PUSH HL

                rept 3
                SRA H
                RR L
                endr

                ; NEG HL
                XOR A
                SUB L
                LD L, A
                SBC A, A
                SUB H
                LD H, A
                POP DE
                ADD HL, DE
                LD (IX + FObject.Velocity.Y), HL

.Speed          LD A, (IX + FObject.EnginePower)
                OR A
                RET Z
                LD C, A

                ;
                LD A, #FF
                JP P, .Apply
                LD A, #01
                CHECK_PLAYER_INPUT_FLAG DECREASE_SPEED_BIT
                RET NZ

.Apply          ADD A, C
                LD (IX + FObject.EnginePower), A

                RET

                endif ; ~_CORE_MODULE_OPEN_WORLD_OBJECT_PLAYER_DECELERATION_
