
                ifndef _MODULE_GAME_INPUT_MAP_MOVEMENT_
                define _MODULE_GAME_INPUT_MAP_MOVEMENT_
; -----------------------------------------
; перемещение карты влево
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
MovementLeft:   LD HL, PlayerState.MapPosX
                LD A, (HL)
                OR A
                RET Z

                DEC (HL)
                SET_MENU_FLAG MENU_UPDTAE_BIT                                   ; установка флага обновления экрана
                RET
; -----------------------------------------
; перемещение карты вправо
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
MovementRight:  ; -----------------------------------------
                ; получить размер карты (из настроек)
                ; In:
                ;   C - размер карты
                ; -----------------------------------------
                CALL Packs.Map.GetMapSize
                LD A, -SCR_MAP_SIZE_X
                ADD A, C
                LD C, A
                
                LD HL, PlayerState.MapPosX
                LD A, (HL)
                CP C
                RET NC

                INC (HL)
                SET_MENU_FLAG MENU_UPDTAE_BIT                                   ; установка флага обновления экрана
                RET
; -----------------------------------------
; перемещение карты вверх
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
MovementUp:     LD HL, PlayerState.MapPosY
                LD A, (HL)
                OR A
                RET Z

                DEC (HL)
                SET_MENU_FLAG MENU_UPDTAE_BIT                                   ; установка флага обновления экрана
                RET
; -----------------------------------------
; перемещение карты вниз
; In:
; Out:
; Corrupt:
; Note:
; -----------------------------------------
MovementDown:   ; -----------------------------------------
                ; получить размер карты (из настроек)
                ; In:
                ;   C - размер карты
                ; -----------------------------------------
                CALL Packs.Map.GetMapSize
                LD A, -SCR_MAP_SIZE_X
                ADD A, C
                LD C, A
                
                LD HL, PlayerState.MapPosY
                LD A, (HL)
                CP C
                RET NC

                INC (HL)
                SET_MENU_FLAG MENU_UPDTAE_BIT                                   ; установка флага обновления экрана
                RET

                endif ; ~_MODULE_GAME_INPUT_MAP_MOVEMENT_
