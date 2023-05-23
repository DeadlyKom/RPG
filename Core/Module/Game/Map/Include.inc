
                ifndef _CORE_MODULE_GAME_MAP_INCLUDE_
                define _CORE_MODULE_GAME_MAP_INCLUDE_

                module Map
Begin           EQU $

                DISP Adr.Module.Game.Shared                                     ; модификация адреса компиляции с блока общего кода
                include "Core/Module/Game/Initialize/Map/Initialize.asm"        ; первый, точка входа
                include "Loop.asm"
                include "Interrupt.asm"
                include "Core/Module/Game/Render/Map/Include.inc"
                include "Core/Module/Game/Input/Map/Include.inc"
                ENT                                                             ; отмена модификации адреса компиляции
Size            EQU $-Begin

                display " - Game 'Map':\t\t\t\t\t", /A, Begin, " = busy [ ", /D, Size, " bytes  ]"

                endmodule

                endif ; ~_CORE_MODULE_GAME_MAP_INCLUDE_
