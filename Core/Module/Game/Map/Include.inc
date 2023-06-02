
                ifndef _CORE_MODULE_GAME_MAP_INCLUDE_
                define _CORE_MODULE_GAME_MAP_INCLUDE_

                module Map
                display " - Game 'Map':\t\t\t\t\t", /A, Begin, " = busy [ ", /D, Size, " bytes  ]"
Begin           EQU $

                DISP Adr.Module.Game.Shared                                     ; модификация адреса компиляции с блока общего кода
                include "Core/Module/Game/Initialize/Map/Initialize.asm"        ; первый, точка входа
                include "Loop.asm"
                include "Interrupt.asm"
                include "Core/Module/Game/Render/Map/Include.inc"
                include "Core/Module/Game/Input/Map/Include.inc"

                ; блок подготовки к визуализации карты
                include "Core/Module/OpenWorld/Map/Core.asm"
                include "Core/Module/OpenWorld/Map/Prepare.asm"
                include "Core/Module/OpenWorld/Map/Initialize.asm"
                include "Core/Module/OpenWorld/Map/VoronoiPass.asm"
                include "Core/Module/OpenWorld/Map/Visualization.asm"
                ENT                                                             ; отмена модификации адреса компиляции
Size            EQU $-Begin


                endmodule

                endif ; ~_CORE_MODULE_GAME_MAP_INCLUDE_
