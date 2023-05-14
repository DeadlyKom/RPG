
                ifndef _CORE_MODULE_OPEN_WORLD_OBJECT_UPDATE_NPC_MOVEMENT_
                define _CORE_MODULE_OPEN_WORLD_OBJECT_UPDATE_NPC_MOVEMENT_
; -----------------------------------------
; обновление движение NPC
; In:
;   IX - адрес обрабатываемого объекта FObject
; Out:
; Corrupt:
; Note:
; ----------------------------------------
Movement:       ; -----------------------------------------
                ; расчёт смещения частицы относительно камеры
                ; -----------------------------------------

                LD A, (PlayerState.DeltaCameraPixX)
                LD DE, (IX + FObject.Position.X)
                LD L, A
                ADD A, A
                SBC A, A
                LD H, A
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, DE
                LD (IX + FObject.Position.X), HL                                ; сохранение позиции по горизонтали

                LD A, (PlayerState.DeltaCameraPixY)
                LD DE, (IX + FObject.Position.Y)
                LD L, A
                ADD A, A
                SBC A, A
                LD H, A
                ADD HL, HL
                ADD HL, HL
                ADD HL, HL
                ADD HL, DE
                LD (IX + FObject.Position.Y), HL                                ; сохранение позиции по горизонтали

                RET

                endif ; ~_CORE_MODULE_OPEN_WORLD_OBJECT_UPDATE_PARTICLE_
