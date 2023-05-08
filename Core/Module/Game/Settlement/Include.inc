
                ifndef _CORE_MODULE_GAME_SETTLEMENT_INCLUDE_
                define _CORE_MODULE_GAME_SETTLEMENT_INCLUDE_

                module Settlement
Begin           EQU $

                DISP Adr.Module.Game.Shared                                     ; модификация адреса компиляции с блока общего кода
                include "Core/Module/Game/Initialize/Settlement/Initialize.asm"  ; первый, точка входа
                include "Loop.asm"
                include "Interrupt.asm"
                include "Core/Module/Game/Render/Settlement/Include.inc"
                include "Core/Module/Game/Input/Settlement/Include.inc"
                ENT                                                             ; отмена модификации адреса компиляции
Size            EQU $-Begin

                display " - Game 'Settlement':\t\t\t\t\t", /A, Begin, " = busy [ ", /D, Size, " bytes  ]"

                endmodule

                endif ; ~_CORE_MODULE_GAME_SETTLEMENT_INCLUDE_
