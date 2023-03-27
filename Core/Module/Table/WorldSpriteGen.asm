                ifndef _CORE_MODULE_TABLE_WORLD_SPRITE_GENERATION_
                define _CORE_MODULE_TABLE_WORLD_SPRITE_GENERATION_

                module Tables
; -----------------------------------------
; генерация
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
WorldSpriteGen: SHOW_SHADOW_SCREEN                                              ; отображение теневого экрана
                SET_PAGE_GRAPHICS                                               ; включить страницу графики

                ; распаковк графики
                LD HL, Adr.Graphics.Pack1
                LD DE, MemBank_01_SCR
                CALL Decompressor.Forward

                SET_SCREEN_SHADOW                                               ; включение страницы второго экрана

                ; -----------------------------------------
                ; генерация смещёных спрайтов тайлопары
                ; -----------------------------------------
                LD IX, Adr.WorldSpr
                LD HL, .TableTilepairs
                LD B, .Num

.TilepairsLoop  LD E, (HL)
                INC HL
                LD D, (HL)
                INC HL
                PUSH DE
                EXX
                POP BC

                ; расчёт адреса 2-го тайла
                LD H, HIGH MemBank_01_SCR >> 2
                LD A, B
                ADD A, A    ; x2
                ADD A, A    ; x4
                ADD A, A    ; x8
                LD L, A
                ADD HL, HL  ; x16
                ADD HL, HL  ; x32

                EX DE, HL

                ; расчёт адреса 1-го тайла
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

                ; 1-ый байт 1-го тайла
                LD A, (BC)
                INC BC
                LD H, A
                
                ; 2-ой байт 1-го тайла
                LD A, (BC)
                INC BC
                LD L, A

                ; 1-ый байт 2-го тайла
                LD A, (DE)
                INC DE
                INC DE

                EX AF, AF'
                JR Z, .Forward_0

                LD (IX + 0), L
                LD (IX + 1), H
                JR .Forward_0_

.Forward_0      LD (IX + 0), H
                LD (IX + 1), L
.Forward_0_     EX AF, AF'
                ; -----------------------------------------
                ; 1-ый сдвиг
                ; -----------------------------------------

                rept 2
                ADD A, A
                ADC HL, HL
                endr

                EX AF, AF'
                JR Z, .Forward_2

                LD (IX + 32), L
                LD (IX + 33), H
                JR .Forward_2_

.Forward_2      LD (IX + 32), H
                LD (IX + 33), L
.Forward_2_     EX AF, AF'

                ; -----------------------------------------
                ; 2-ой сдвиг
                ; -----------------------------------------

                rept 2
                ADD A, A
                ADC HL, HL
                endr
                
                EX AF, AF'
                JR Z, .Forward_4

                LD (IX + 64), L
                LD (IX + 65), H
                JR .Forward_4_

.Forward_4      LD (IX + 64), H
                LD (IX + 65), L
.Forward_4_     EX AF, AF'

                ; -----------------------------------------
                ; 3-ий сдвиг
                ; -----------------------------------------

                rept 2
                ADD A, A
                ADC HL, HL
                endr
                
                EX AF, AF'
                JR Z, .Forward_6

                LD (IX + 96), L
                LD (IX + 97), H
                JR .Forward_6_

.Forward_6      LD (IX + 96), H
                LD (IX + 97), L
.Forward_6_     EX AF, AF'

                INC IX
                INC IX

                EX AF, AF'
                DEC A
                JR NZ, .ShiftLoop

                ;
                LD BC, 128 - 32
                ADD IX, BC

                EXX
                DEC B
                JP NZ, .TilepairsLoop

                RET

.TableTilepairs DB #00, #00 ; 0
                DB #00, #01 ; 1
                DB #01, #01 ; 2
                DB #01, #02 ; 3
                DB #02, #02 ; 4
                DB #02, #01 ; 5
                DB #01, #00 ; 6

                DB #00, #03 ; 7
                DB #03, #04 ; 8
                DB #04, #04 ; 9
                DB #04, #05 ; A
                DB #05, #00 ; B

                DB #00, #06 ; C
                DB #06, #07 ; D
                DB #07, #07 ; E
                DB #07, #08 ; F
                DB #08, #00 ; 10

                DB #00, #09 ; 11
                DB #09, #0A ; 12
                DB #0A, #0A ; 13
                DB #0A, #0B ; 14
                DB #0B, #00 ; 15
.Num            EQU ($-.TableTilepairs) >> 1

                display " - World sprite generatuion: \t\t[", /D, WorldSpriteGen.Num, " tilepairs]\t", /A, ScrAdrGen, " = busy [ ", /D, $ - ScrAdrGen, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_TABLE_WORLD_SPRITE_GENERATION_
