
                ifndef _CORE_MODULE_OPEN_WORLD_OBJECT_INITIALIZE_INCLUDE_
                define _CORE_MODULE_OPEN_WORLD_OBJECT_INITIALIZE_INCLUDE_

                module Initialize

                display " * Spawn bject:\t\t\t\t\t", /A, Begin, " = busy [ ", /D, Size, " bytes  ]"
Begin           EQU $

                include "Core.asm"
                include "Initialize.asm"
                include "Spawn.asm"
                include "Spawn_NPC.asm"
                include "Spawn_Player.asm"
                include "Spawn_Decal.asm"
                include "Spawn_Particle.asm"
                include "Spawn_Mine.asm"
Size            EQU $-Begin

                endmodule

                endif ; ~ _CORE_MODULE_OPEN_WORLD_OBJECT_INITIALIZE_INCLUDE_
