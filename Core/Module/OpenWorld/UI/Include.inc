
                ifndef _CORE_MODULE_OPEN_WORLD_WASTELAND_UI_BAR_INCLUDE_
                define _CORE_MODULE_OPEN_WORLD_WASTELAND_UI_BAR_INCLUDE_

                module UI

                display " * UI:\t\t\t\t\t\t", /A, Begin, " = busy [ ", /D, Size, " bytes  ]"
Begin           EQU $
                include "Bar_Animation.asm"
                include "Health_Animation.asm"
                include "Gas_Tick.asm"
                include "Gas_Animation.asm"
                include "Turbo_Tick.asm"
                include "Turbo_Animation.asm"
Size            EQU $ - Begin

                endmodule

                endif ; ~_CORE_MODULE_OPEN_WORLD_WASTELAND_UI_BAR_INCLUDE_
