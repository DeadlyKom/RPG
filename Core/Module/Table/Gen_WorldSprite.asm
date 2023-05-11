                ifndef _CORE_MODULE_TABLE_GENERATOR_WORLD_SPRITE_
                define _CORE_MODULE_TABLE_GENERATOR_WORLD_SPRITE_

                module Tables
; -----------------------------------------
; генерация
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Gen_WorldSpr:   SHOW_SHADOW_SCREEN                                              ; отображение теневого экрана
                SET_PAGE_GRAPHICS_1                                             ; включить страницу графики

                ; распаковк графики
                LD HL, Adr.Graphics.Pack1
                LD DE, MemBank_01_SCR
                CALL Decompressor.Forward

                SET_SCREEN_SHADOW                                               ; включение страницы второго экрана

                ; очистка буфера поиска тайлопар
                LD HL, (Adr.WorldTilepair + Size.WorldTilepair) & 0xFFFF
                LD DE, #0000
                CALL SafeFill.b256

                ; -----------------------------------------
                ; генерация смещёных спрайтов тайлопары
                ; -----------------------------------------
                LD HL, TableTilepairs
                LD B, TableTilepairs.Num

.TilepairsLoop  ; -----------------------------------------
                ; чтение индексов 2х тайлов (1 тайлопара)
                ; -----------------------------------------
                LD E, (HL)
                INC HL
                LD D, (HL)
                INC HL
                PUSH DE
                EXX
                POP BC

                ; -----------------------------------------
                ; заполнение таблицы поиска тайлопар
                ; -----------------------------------------
                LD A, C                                                         ; левый тайл
                ADD A, A
                ADD A, A
                ADD A, A
                ADD A, A
                OR B                                                            ; правый тайл

                ; -----------------------------------------
                ;   значение в аккумуляторе
                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | L3 | L2 | L1 | L0 | R3 | R2 | R1 | R0 |
                ;   +----+----+----+----+----+----+----+----+
                ;
                ;   L3-L0   [7..4]  - номер левого тайла
                ;   R3-R0   [3..0]  - номер правого тайла
                ; -----------------------------------------
                LD H, HIGH Adr.WorldTilepair
                LD L, A

                ; расчёт индекса тайлопары
                LD A, TableTilepairs.Num
                EXX
                SUB B
                EXX
                LD (HL), A

                ;   A - ID тайлопары
                ;   C - номер левого индекса
                CALL Table
                ;   IX - адрес левого тайла (не сдвигаемый)
                ;   IY - адрес правого тайла (сдвигаемый)

                ; -----------------------------------------
                ; расчёт адресов 2х тайлов  (распакованных)
                ; -----------------------------------------

                ; расчёт адреса правого тайла
                LD H, HIGH MemBank_01_SCR >> 2
                LD A, B
                ADD A, A    ; x2
                ADD A, A    ; x4
                ADD A, A    ; x8
                LD L, A
                ADD HL, HL  ; x16
                ADD HL, HL  ; x32

                EX DE, HL

                ; расчёт адреса левого тайла
                LD H, HIGH MemBank_01_SCR >> 2
                LD A, C
                ADD A, A    ; x2
                ADD A, A    ; x4
                ADD A, A    ; x8
                LD L, A
                ADD HL, HL  ; x16
                ADD HL, HL  ; x32
                LD B, H
                LD C, L

                LD A, 16

.ShiftLoop      BIT 0, A
                EX AF, AF'

                ; -----------------------------------------
                ; 0-ой сдвиг
                ; -----------------------------------------

                ; 1-ый байт левого тайла
                LD A, (BC)
                INC BC
                LD H, A
                
                ; 2-ой байт левого тайла
                LD A, (BC)
                INC BC
                LD L, A

                ; 1-ый байт правого тайла
                LD A, (DE)
                INC DE
                INC DE

                EX AF, AF'
                JR Z, .x0

                LD (IX + 0), L
                LD (IX + 1), H
                JR .x0_

.x0             LD (IX + 0), H
                LD (IX + 1), L
.x0_            EX AF, AF'

                ; -----------------------------------------
                ; 1-ый сдвиг
                ; -----------------------------------------

                rept 2
                ADD A, A
                ADC HL, HL
                endr

                EX AF, AF'
                JR Z, .x2

                LD (IY + 0), L
                LD (IY + 1), H
                JR .x2_

.x2             LD (IY + 0), H
                LD (IY + 1), L
.x2_            EX AF, AF'

                ; -----------------------------------------
                ; 2-ой сдвиг
                ; -----------------------------------------

                rept 2
                ADD A, A
                ADC HL, HL
                endr
                

                EX AF, AF'
                JR Z, .x4

                LD (IY + 32), L
                LD (IY + 33), H
                JR .x4_

.x4             LD (IY + 32), H
                LD (IY + 33), L
.x4_            EX AF, AF'

                ; -----------------------------------------
                ; 3-ий сдвиг
                ; -----------------------------------------

                rept 2
                ADD A, A
                ADC HL, HL
                endr
                

                EX AF, AF'
                JR Z, .x6

                LD (IY + 64), L
                LD (IY + 65), H
                JR .x6_

.x6             LD (IY + 64), H
                LD (IY + 65), L
.x6_            EX AF, AF'

                INC IX
                INC IX
                INC IY
                INC IY

                EX AF, AF'
                DEC A
                JR NZ, .ShiftLoop

                EXX
                DEC B
                JP NZ, .TilepairsLoop

                RET

; -----------------------------------------
; генерация
; In:
;   A - ID тайлопары
;   C - номер левого индекса
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Table:          PUSH BC

                LD B, A
                LD A, C
                LD (.LeftIndex), A
                LD C, #04

.TableLoop      ; -----------------------------------------
                ; расчёт адреса спрайта
                ; -----------------------------------------
                DEC C
                LD A, C
                OR A
                JR NZ, .Shift

                ; address = Adr.WorldSpr + LeftIndex * 32
                LD DE, Adr.WorldSpr
.LeftIndex      EQU $+1  
                LD HL, #0000
                ADD HL, HL  ; x2
                ADD HL, HL  ; x4
                ADD HL, HL  ; x8
                ADD HL, HL  ; x16
                ADD HL, HL  ; x32
                ADD HL, DE

                PUSH HL
                POP IX
                JR .Set

.Shift          ; -----------------------------------------
                ; address = Adr.WorldSpr + 16 * 32 + ID * 96 + (Shift - 1) * 32
                ; -----------------------------------------
                
                ; ID * 96
                LD A, B
                ADD A, A    ; x2
                LD L, A
                LD H, #00
                ADD HL, HL  ; x4
                ADD HL, HL  ; x8
                ADD HL, HL  ; x16
                ADD HL, HL  ; x32
                LD D, H
                LD E, L
                ADD HL, HL  ; x64
                ADD HL, DE  ; x96
                
                ; (Shift - 1) * 32
                LD A, C
                DEC A
                ADD A, A    ; x2
                ADD A, A    ; x4
                ADD A, A    ; x8
                ADD A, A    ; x16
                ADD A, A    ; x32

                ; ID * 96 + (Shift - 1) * 32
                ADD A, L
                LD L, A
                ADC A, H
                SUB L
                LD H, A

                ; Adr.WorldSpr + 16 * 32 + ID * 96 + (Shift - 1) * 32
                LD DE, Adr.WorldSpr + 16 * 32
                ADD HL, DE

                PUSH HL
                POP IY

.Set            ; -----------------------------------------
                ; расчёт адреса таблицы
                ; -----------------------------------------

                LD A, B
                AND %01111111
                LD E, A
                LD A, C
                AND %00000011
                OR HIGH Adr.WorldSprTable
                LD D, A
                ; -----------------------------------------
                ;   регистровая пара DE хранит адрес 2х значений
                ;   номер тайла + смещение
                ;       +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
                ;       | 15 | 14 | 13 | 12 | 11 | 10 |  9 |  8 |   |  7 |  6 |  5 |  4 |  3 |  2 |  1 |  0 |
                ;       +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
                ;       | 1  | 1  | A3 | A2 | A1 | A0 | S1 | S0 |   | 0  | T6 | T5 | T4 | T3 | T2 | T1 | T0 |
                ;       +----+----+----+----+----+----+----+----+   +----+----+----+----+----+----+----+----+
                ;
                ;   A3-A0   [13..10]- адрес таблицы
                ;   S1,S0   [1,0]   - номер сдвига
                ; -----------------------------------------
                
                EX DE, HL
                LD (HL), E
                SET 7, L
                LD (HL), D

                INC C
                DEC C
                JR NZ, .TableLoop

                POP BC
                RET

TableTilepairs  DB #00, #00 ; 0
                DB #02, #00 ; 1
                DB #04, #00 ; 2
                DB #06, #00 ; 3
                DB #08, #00 ; 4
                DB #0A, #00 ; 4
                DB #0C, #00 ; 5
                DB #0E, #00 ; 6

                DB #00, #01 ; 7
                DB #02, #01 ; 8
                DB #04, #01 ; 8 !
                DB #06, #01 ; 8 !
                DB #08, #01 ; 8 !
                DB #0A, #01 ; 8 !
                DB #0C, #01 ; 8 !
                DB #0E, #01 ; 9

                DB #0F, #02 ; A

                DB #0F, #03 ; B

                DB #00, #04 ; C
                DB #02, #04 ; C !
                DB #04, #04 ; D
                DB #06, #04 ; E
                DB #08, #04 ; E !
                DB #0A, #04 ; E !
                DB #0C, #04 ; F
                DB #0E, #04 ; 10

                DB #00, #05 ; 11
                DB #02, #05 ; 12
                DB #04, #05 ; 13
                DB #06, #05 ; 14
                DB #08, #05 ; 15
                DB #0A, #05 ; 16
                DB #0C, #05 ; 17
                DB #0E, #05 ; 18

                DB #0F, #06 ; 19

                DB #0F, #07 ; 1A

                DB #00, #08 ; 1B
                DB #02, #08 ; 1B !
                DB #04, #08 ; 1B !
                DB #06, #08 ; 1C
                DB #08, #08 ; 1D
                DB #0A, #08 ; 1E
                DB #0C, #08 ; 1F
                DB #0E, #08 ; 20

                DB #00, #09
                DB #02, #09
                DB #04, #09 ;   !
                DB #06, #09
                DB #08, #09
                DB #0A, #09
                DB #0C, #09
                DB #0E, #09

                DB #0F, #0A

                DB #0F, #0B

                DB #00, #0C
                DB #02, #0C
                DB #04, #0C
                DB #06, #0C
                DB #08, #0C
                DB #0A, #0C
                DB #0C, #0C
                DB #0E, #0C

                DB #00, #0D
                DB #02, #0D
                DB #04, #0D
                DB #06, #0D
                DB #08, #0D
                DB #0A, #0D
                DB #0C, #0D
                DB #0E, #0D

                DB #0F, #0E

                DB #01, #0F
                DB #03, #0F
                DB #05, #0F
                DB #07, #0F
                DB #09, #0F
                DB #0B, #0F
                DB #0D, #0F
                DB #0F, #0F

.Num            EQU ($-TableTilepairs) >> 1

                display " - World sprite generatuion: \t\t[", /D, TableTilepairs.Num, " tilepairs]\t", /A, Gen_WorldSpr, " = busy [ ", /D, $ - Gen_WorldSpr, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_TABLE_GENERATOR_WORLD_SPRITE_
