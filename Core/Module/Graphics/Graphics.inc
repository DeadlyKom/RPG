
                ifndef _CORE_MODULE_GRAPHICS_TILE_WORLD_GRAPHICS_PACK_1_
                define _CORE_MODULE_GRAPHICS_TILE_WORLD_GRAPHICS_PACK_1_
World:          incbin "Core/Module/Graphics/Tile/World/Sprite/Compressed/Ground/Ground.pack.ar"
                display " - Ground.pack: \t\t\t\t\t", /A, World, " = busy [ ", /D, $ - World, " bytes  ]"
Cars:
.A              include "Core/Module/Graphics/Car/A/Include.inc"
                display " - Car A: \t\t\t\t\t\t", /A, Cars.A, " = busy [ ", /D, $ - Cars.A, " bytes  ]"
.B              include "Core/Module/Graphics/Car/B/Include.inc"
                display " - Car B: \t\t\t\t\t\t", /A, .B, " = busy [ ", /D, $ - .B, " bytes  ]"
Declas:         include "Core/Module/Graphics/Tile/World/Sprite/Original/Decal/Include.inc"
                display " - Decals: \t\t\t\t\t\t", /A, Declas, " = busy [ ", /D, $ - Declas, " bytes  ]"

VFX:
.Dust           include "Core/Module/Graphics/VFX/Dust/Include.inc"
                display " - Dust: \t\t\t\t\t\t", /A, VFX.Dust, " = busy [ ", /D, $ - VFX.Dust, " bytes  ]"

.Smoke          include "Core/Module/Graphics/VFX/Smoke/Include.inc"
                display " - Smoke: \t\t\t\t\t\t", /A, .Smoke, " = busy [ ", /D, $ - .Smoke, " bytes  ]"

                endif ; ~ _CORE_MODULE_GRAPHICS_TILE_WORLD_GRAPHICS_PACK_1_
