
                ifndef _CORE_MODULE_GRAPHICS_VFX_INCLUDE_
                define _CORE_MODULE_GRAPHICS_VFX_INCLUDE_

                module VFX

                include "Core/Module/Graphics/VFX/Dust/Info.inc"
                include "Core/Module/Graphics/VFX/Smoke/Info.inc"
                include "Core/Module/Graphics/VFX/Explosion/Info.inc"

Table:          ; PARTICLE_DUST                                                 ; 0x00
                DW SpriteInfo.Dust
                ; PARTICLE_SMOKE                                                ; 0x01
                DW SpriteInfo.Smoke
                ; PARTICLE_EXPLOSION                                            ; 0x02
                DW SpriteInfo.Explosion

                endmodule

                endif ; ~_CORE_MODULE_GRAPHICS_VFX_INCLUDE_
