
                ifndef _CORE_MODULE_GAME_WASTELAND_INCLUDE_
                define _CORE_MODULE_GAME_WASTELAND_INCLUDE_

                module Wasteland
Begin           EQU $

                DISP Adr.Module.Game.Shared                                     ; модификация адреса компиляции с блока общего кода
                include "Core/Module/Game/Initialize/Wasteland/Initialize.asm"  ; первый, точка входа
                include "Loop.asm"
                include "Interrupt.asm"
                include "Core/Module/Game/Render/Wasteland/Include.inc"
                include "Core/Module/Game/Input/Wasteland/Include.inc"
                ENT                                                             ; отмена модификации адреса компиляции
Size            EQU $-Begin

                display " - Game 'Wasteland':\t\t\t\t\t", /A, Begin, " = busy [ ", /D, Size, " bytes  ]"

                endmodule

                endif ; ~_CORE_MODULE_GAME_WASTELAND_INCLUDE_
