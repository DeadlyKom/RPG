
                ifndef _CORE_MODULE_GAME_MAIN_MENU_INCLUDE_
                define _CORE_MODULE_GAME_MAIN_MENU_INCLUDE_

                module MainMenu
Begin           EQU $

                DISP Adr.Module.Game.Shared                                     ; модификация адреса компиляции с блока общего кода
                include "Core/Module/Game/Initialize/MainMenu/Initialize.asm"   ; первый, точка входа
                include "Loop.asm"
                include "Interrupt.asm"
                include "Core/Module/Game/Render/MainMenu/Include.inc"
                include "Core/Module/Game/Input/MainMenu/Include.inc"
                ENT                                                             ; отмена модификации адреса компиляции
Size            EQU $-Begin

                display " - Game 'Main Menu':\t\t\t\t\t", /A, Begin, " = busy [ ", /D, Size, " bytes  ]"

                endmodule

                endif ; ~_CORE_MODULE_GAME_MAIN_MENU_INCLUDE_
