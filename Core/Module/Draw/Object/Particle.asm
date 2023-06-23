
                ifndef _CORE_MODULE_DRAW_OBJECT_PARTICLE_
                define _CORE_MODULE_DRAW_OBJECT_PARTICLE_
; -----------------------------------------
; обновление частицы
; In:
;   IX - адрес обрабатываемого объекта FObjectParticle
; Out:
; Corrupt:
; Note:
; ----------------------------------------
DrawParticle:   BIT VISIBLE_OBJECT_BIT, (IX + FObjectParticle.Type)             ; проверка флаг видимости объекта
                RET Z                                                           ; выход, если объект невидим
                
                ; сохранеие текущей страницы
                LD A, (Adr.Port_7FFD)
                LD (.RestoreMemPage), A                                         ; сохранение страницы спрайта

                ; подготовка позиции вывода объекта
                LD HL, (IX + FObjectParticle.Position.X)
                LD (Draw.Prepare.PosX), HL                                      ; сохранение позиции по горизонтали
                LD HL, (IX + FObjectParticle.Position.Y)
                LD DE, (IX + FObjectParticle.Height)
                ADD HL, DE
                LD (Draw.Prepare.PosY), HL                                      ; сохранение позиции по вертикали

                ; -----------------------------------------
                ; расчёт адреса
                ; -----------------------------------------
                
                ; расчёт адреса анимации
                LD A, (IX + FObjectParticle.Subtype)
                ADD A, A
                ADD A, LOW VFX.Table
                LD L, A
                ADC A, HIGH VFX.Table
                SUB L
                LD H, A

                ; расчёт адреса фрейма анимации 
                LD A, (IX + FObjectParticle.AnimFrame)
                ADD A, (HL)
                INC HL
                LD H, (HL)
                LD L, A
                ADC A, H
                SUB L
                LD H, A

                ; -----------------------------------------
                ; чтение информации о спрайте
                ; -----------------------------------------
                CALL Utils.SpriteParse

                ; -----------------------------------------
                ; подготовка спрайта перед выводом
                ; -----------------------------------------

                CALL Draw.Prepare                                               ; проверка и подготовка спрайта перед отрисовкой
                CALL C, Draw.Sprite                                             ; если все проверки успешны, отрисовка спрайта

                ; востановление страницы
.RestoreMemPage EQU $+1
                LD A, #00
                JP SetPage

                include "Core/Module/Graphics/VFX/Include.inc"

                display " - Draw object 'PARTICLE':\t\t\t\t", /A, DrawParticle, " = busy [ ", /D, $ - DrawParticle, " bytes  ]"

                endif ; ~_CORE_MODULE_DRAW_OBJECT_PARTICLE_
