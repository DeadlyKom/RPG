
                ifndef _CORE_MODULE_AI_INCLUDE_
                define _CORE_MODULE_AI_INCLUDE_

                module AI
Begin           EQU $
                include "Task/Include.inc"
                include "Composite/Include.inc"
                include "Behavior/Control.asm"

                display " - AI:\t\t\t\t\t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_AI_INCLUDE_