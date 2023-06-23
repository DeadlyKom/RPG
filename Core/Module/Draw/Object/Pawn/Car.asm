
                ifndef _CORE_MODULE_DRAW_OBJECT_CAR_
                define _CORE_MODULE_DRAW_OBJECT_CAR_
; -----------------------------------------
; отображение машины
; In:
;   IX - указывает на структуру FObject
; Out:
; Corrupt:
; Note:
; -----------------------------------------
Car:            ; сохранеие текущей страницы
                LD A, (Adr.Port_7FFD)
                LD (.RestoreMemPage), A                                         ; сохранение страницы спрайта

                ; подготовка позиции вывода объекта
                LD HL, (IX + FObject.Position.X)
                LD (Draw.Prepare.PosX), HL                                      ; сохранение позиции по горизонтали
                LD HL, (IX + FObject.Position.Y)
                LD (Draw.Prepare.PosY), HL                                      ; сохранение позиции по вертикали

                ; -----------------------------------------
                ; расчёт адреса
                ; -----------------------------------------
                LD A, (IX + FObject.Type)
                LD C, (IX + FObject.Direction)
                CALL GetSpriteInfo

                ; -----------------------------------------
                ; чтение информации о спрайте
                ; -----------------------------------------
                CALL Utils.SpriteParse

                ; -----------------------------------------
                ; подготовка спрайта перед выводом
                ; -----------------------------------------
                PUSH IX
                CALL Draw.Prepare                                               ; проверка и подготовка спрайта перед отрисовкой
                CALL C, Draw.Sprite                                             ; если все проверки успешны, отрисовка спрайта

                ; востановление страницы
.RestoreMemPage EQU $+1
                LD A, #00
                CALL SetPage

                POP IX
                JP MuzzleFlash

                display " - Draw object 'CAR':\t\t\t\t\t", /A, Car, " = busy [ ", /D, $ - Car, " bytes  ]"

                endif ; ~ _CORE_MODULE_DRAW_OBJECT_CAR_
