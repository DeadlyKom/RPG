
                ifndef _MODULE_GAME_RENDER_MAP_UI_DRAW_PLAYER_
                define _MODULE_GAME_RENDER_MAP_UI_DRAW_PLAYER_
; -----------------------------------------
; отображение UI маркера игрока
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
DrawPlayer:     LD HL, .Counter
                DEC (HL)
                RET NZ
                LD (HL), #05

                INC HL
                DEC (HL)
                LD A, (HL)
                JR NZ, .Draw
                LD (HL), #01 + 1

.Draw           LD (.Last), A
                EX AF, AF'

                ; горизонталь
                LD HL, (PlayerState.CameraPosX + 1)
                LD DE, (PlayerState.WorldLeftTopPos + 0)                        ; X.Low
                EXX
                LD HL, (PlayerState.CameraPosX + 3)
                LD DE, (PlayerState.WorldLeftTopPos + 2)                        ; X.High

                ; -----------------------------------------
                ; вычитание 32-битных чисел
                ; In :
                ;   HLHL' - 32-битное уменьшаемое число
                ;   DEDE' - 32-битное вычитаемое число
                ; Out :
                ;   DEHL  - разность 32-битных чисел
                ; -----------------------------------------
                CALL Math.Sub32_32

                ; проверка выхода за пределы окна видимости
                LD A, (PlayerState.MapPosX)
                NEG
                ADD A, H
                RET M                                                           ; выход, если координаты за пределами окна видимости
                SUB SCR_MAP_SIZE_X
                RET NC                                                          ; выход, если координаты за пределами окна видимости
                ADD A, SCR_MAP_SIZE_X
                LD H, A

                ; приведение к знакоместа к пикселям
                ADD HL, HL  ; x2
                ADD HL, HL  ; x4
                ADD HL, HL  ; x8

                ; сохрнить значение по горизонтали
                LD A, H

                ; вертикаль

                LD HL, (PlayerState.CameraPosY + 1)
                LD DE, (PlayerState.WorldLeftTopPos + 4)                        ; Y.Low
                EXX
                LD HL, (PlayerState.CameraPosY + 3)
                LD DE, (PlayerState.WorldLeftTopPos + 6)                        ; Y.High

                ; -----------------------------------------
                ; вычитание 32-битных чисел
                ; In :
                ;   HLHL' - 32-битное уменьшаемое число
                ;   DEDE' - 32-битное вычитаемое число
                ; Out :
                ;   DEHL  - разность 32-битных чисел
                ; -----------------------------------------
                CALL Math.Sub32_32

                ; проверка выхода за пределы окна видимости
                LD E, A
                LD A, (PlayerState.MapPosY)
                NEG
                ADD A, H
                RET M                                                           ; выход, если координаты за пределами окна видимости
                SUB SCR_MAP_SIZE_Y
                RET NC                                                          ; выход, если координаты за пределами окна видимости
                ADD A, SCR_MAP_SIZE_Y
                LD H, A

                ; приведение к знакоместа к пикселям
                ADD HL, HL  ; x2
                ADD HL, HL  ; x4
                ADD HL, HL  ; x8

                ; инициалзация позиций
                LD D, H

                EX AF, AF'
                JP Player

.ForceDraw      LD A, (.Last)
                JR .Draw

.Counter        DB #01
.Anim           DB #01 + 1
.Last           DB #00

                endif ; ~_MODULE_GAME_RENDER_MAP_UI_DRAW_PLAYER_
