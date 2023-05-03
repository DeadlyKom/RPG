
                ifndef _CORE_MODULE_DRAW_MUZZLE_FLASH_
                define _CORE_MODULE_DRAW_MUZZLE_FLASH_
; -----------------------------------------
; отображение вспышки выстрелов
; In:
;   IX - указывает на структуру FObject
; Out:
; Corrupt:
; Note:
; -----------------------------------------
MuzzleFlash:    ; проверка ведёния огоня
                BIT STATE_FIRE_BIT, (IX + FObject.State)
                RET Z                                                           ; выход если объект не ведёт огонь

                ; сохранеие текущей страницы
                LD A, (Adr.Port_7FFD)
                LD (.RestoreMemPage), A                                         ; сохранение страницы спрайта

                ; получение смещение относительно пивата машины
                CALL Kernel.Object.GetFireSocket
                ; -----------------------------------------
                ; приведение к мировой впозиции
                ; In:
                ;   DE - смещение (D - y, E - x)
                ;   IX - адрес объекта копирования позиции FObject
                ; Out:
                ;   HL - новая позиция по вертикали
                ;   DE - новая позиция по горизонтали
                ; -----------------------------------------
                CALL Func.WorldPosition

                ; подготовка позиции вывода объекта
                LD (Draw.Prepare.PosY), HL                                      ; сохранение позиции по вертикали
                LD (Draw.Prepare.PosX), DE                                      ; сохранение позиции по горизонтали

                ; -----------------------------------------
                ; расчёт адреса
                ; -----------------------------------------

                ; -----------------------------------------
                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | .. | .. | .. | .. | AF | .. | .. | .. |
                ;   +----+----+----+----+----+----+----+----+
                ;
                ;   AF      [3]     - номер анимации вспышки выстрела
                ; -----------------------------------------
                LD A, R
                RRA
                LD C, A;(IX + FObject.AnimCounter)

                ; -----------------------------------------
                ;      7    6    5    4    3    2    1    0
                ;   +----+----+----+----+----+----+----+----+
                ;   | B3 | B2 | B1 | B0 | .. | .. | .. | .. |
                ;   +----+----+----+----+----+----+----+----+
                ;
                ;   B3-B0   [7..4]  - направление
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
                LD A, (IX + FObject.MuzzleFlash)
                XOR C
                AND OBJECT_DIRECTION_MASK << 1
                XOR C
                AND %11111000
                ; -----------------------------------------
                ; в аккумуляторе
                ;
                ;   +----+----+----+----+----+----+----+----+
                ;   |  7 |  6 |  5 |  4 |  3 |  2 |  1 |  0 |
                ;   +----+----+----+----+----+----+----+----+
                ;   | B3 | B2 | B1 | B0 | AF |  0 |  0 |  0 |
                ;   +----+----+----+----+----+----+----+----+
                ; -----------------------------------------

                ; добавить адрес таблицы
                ADD A, LOW .Table
                LD L, A
                ADC A, HIGH .Table
                SUB L
                LD H, A

                ; -----------------------------------------
                ; чтение информации о спрайте
                ; -----------------------------------------
                LD E, (HL)                                                      ; FSprite.Info.Height
                INC HL
                LD A, (HL)                                                      ; FSprite.Info.OffsetY
                LD (Draw.Prepare.SOy), A
                INC HL
                LD D, (HL)                                                      ; FSprite.Info.Width
                LD (Draw.Prepare.Size), DE
                INC HL
                LD A, (HL)                                                      ; FSprite.Info.OffsetX
                LD (Draw.Prepare.SOx), A
                INC HL
                LD A, (HL)                                                      ; FSprite.Offset
                INC HL
                LD (GameConfig.SpriteOffsetRef), A
                LD A, (HL)                                                      ; FSprite.Page
                INC HL
                LD E, CSIF_OR_XOR << 1
                ADD A, A
                RR E
                RRA
                CALL SetPage
                LD A, E
                LD (GameConfig.SpriteFlagRef), A
                LD E, (HL)                                                      ; FSprite.Data.Low
                INC HL
                LD D, (HL)                                                      ; FSprite.Data.High
                EX DE, HL

                ; -----------------------------------------
                ; подготовка спрайта перед выводом
                ; -----------------------------------------

                CALL Draw.Prepare                                               ; проверка и подготовка спрайта перед отрисовкой
                CALL C, Draw.Sprite                                             ; если все проверки успешны, отрисовка спрайта

                ; востановление страницы
.RestoreMemPage EQU $+1
                LD A, #00
                JP SetPage

.Table          include "Core/Module/Graphics/VFX/MuzzleFlash/Info.inc"

                display " - Draw object 'MUZZLE FLASH':\t\t\t", /A, MuzzleFlash, " = busy [ ", /D, $ - MuzzleFlash, " bytes  ]"

                endif ; ~ _CORE_MODULE_DRAW_OBJECT_CAR_
