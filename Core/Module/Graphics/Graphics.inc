
                ifndef _CORE_MODULE_GRAPHICS_TILE_WORLD_GRAPHICS_PACK_1_
                define _CORE_MODULE_GRAPHICS_TILE_WORLD_GRAPHICS_PACK_1_
World:          incbin "Core/Module/Graphics/Tile/World/Sprite/Compressed/Ground/Ground.pack.ar"
                display " - Ground.pack: \t\t\t\t\t", /A, World, " = busy [ ", /D, $ - World, " bytes  ]"
Cars:
.A              include "Core/Module/Graphics/Car/A/Include.inc"
                display " - Car: \t\t\t\t\t\t", /A, Cars.A, " = busy [ ", /D, $ - Cars.A, " bytes  ]"

                endif ; ~ _CORE_MODULE_GRAPHICS_TILE_WORLD_GRAPHICS_PACK_1_
