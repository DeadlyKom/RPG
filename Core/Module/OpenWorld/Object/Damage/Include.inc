
                ifndef _CORE_MODULE_OPEN_WORLD_OBJECT_DAMAGE_INCLUDE_
                define _CORE_MODULE_OPEN_WORLD_OBJECT_DAMAGE_INCLUDE_

                module Damage

                display " - Damage:\t\t\t\t\t\t", /A, Begin, " = busy [ ", /D, Size, " bytes  ]"
Begin           EQU $
                include "Apply.asm"
                include "ApplyVehicle.asm"
                include "ApplyExplosion.asm"
Size            EQU $-Begin

                endmodule

                endif ; ~ _CORE_MODULE_OPEN_WORLD_OBJECT_DAMAGE_INCLUDE_
