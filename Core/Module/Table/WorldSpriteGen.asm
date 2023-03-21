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
                ; генерация таблицы спрайтов и смещёные спрайты
                ; -----------------------------------------
                LD IX, Adr.WorldSprTable
                LD HL, Adr.WorldSpr - WORLD_TILE_TOTAL_SIZE 
                LD DE, WORLD_TILE_TOTAL_SIZE
                LD B, WORLD_TILE_NUM

                EXX
                LD HL, MemBank_01_SCR
                EXX

.TableLoop      ; -----------------------------------------
                ; расчёт адреса спрайта и заполнение таблицы
                ; -----------------------------------------
                ADD HL, DE
                PUSH HL
                LD (IX + 0), L
                LD (IX + 1), H
                INC IX
                INC IX

                ; -----------------------------------------
                ; копирование спрайтов (после декомпрессии)
                ; -----------------------------------------
                EXX
                POP DE
                PUSH DE                                                         ; сохранение начального адреса копии тайла
                LD BC, WORLD_TILE_SIZE - 2
                CALL Memcpy.FastLDIR
                EX (SP), HL                                                     ; сохранение адреса следующего тайла (после декомпрессии)
                                                                                ; восстановление начального адреса скопированного тайла
               
                ; -----------------------------------------
                ; создание сдвинутых спрайтов
                ; -----------------------------------------

                ; HL - адрес спрайта
                ; DE - адрес спрайта сдвига     (назначение)

                PUSH DE
                POP IY

                ; инициализация
                LD B, 16

.RL_Loop        LD D, (HL)
                INC HL
                LD E, (HL)
                INC HL
                XOR A

                EX DE, HL

                ; 1
                rept 2
                ADD HL, HL
                ADC A, A
                endr

                ; 2 первых байта буферная зона порчи стека
                BIT 0, B
                JR Z, .Forward_6
                LD (IY + 103), L
                LD (IY + 105), A
                JR .Forward_6_
.Forward_6      LD (IY + 103), A
                LD (IY + 105), L
.Forward_6_     LD (IY + 104), H

                ; 2
                rept 2
                ADD HL, HL
                ADC A, A
                endr

                ; 2 первых байта буферная зона порчи стека
                BIT 0, B
                JR Z, .Forward_4
                LD (IY + 52), L
                LD (IY + 54), A
                JR .Forward_4_
.Forward_4      LD (IY + 52), A
                LD (IY + 54), L
.Forward_4_     LD (IY + 53), H

                ; 3
                rept 2
                ADD HL, HL
                ADC A, A
                endr

                ; 2 первых байта буферная зона порчи стека
                BIT 0, B
                JR Z, .Forward_2
                LD (IY + 2), L
                LD (IY + 4), A
                JR .Forward_2_
.Forward_2      LD (IY + 2), A
                LD (IY + 4), L
.Forward_2_     LD (IY + 3), H

                EX DE, HL

                INC IY
                INC IY
                INC IY

                DJNZ .RL_Loop
                POP HL                                                          ; восстановление адреса следующего тайла (после декомпрессии)

                EXX
                DJNZ .TableLoop

                RET

                display " - World sprite generatuion: \t\t\t\t", /A, ScrAdrGen, " = busy [ ", /D, $ - ScrAdrGen, " bytes  ]"
                endmodule

                endif ; ~ _CORE_MODULE_TABLE_WORLD_SPRITE_GENERATION_
