
                ifndef _CORE_MODULE_OPEN_WORLD_OBJECT_INCLUDE_
                define _CORE_MODULE_OPEN_WORLD_OBJECT_INCLUDE_

                module Object

                display " * Object:\t\t\t\t\t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"
                
                include "Core.asm"
                include "Tick.asm"
                include "Update.asm"
                include "Mine.asm"
                include "Decal.asm"
                include "Particle.asm"
                include "NPC/Include.inc"
                include "Damage/Include.inc"
                include "Utils/Include.inc"
                include "Player/Include.inc"
                include "Collision/Include.inc"
                include "Initialize/Include.inc"

                endmodule

                endif ; ~_CORE_MODULE_OPEN_WORLD_OBJECT_INCLUDE_
