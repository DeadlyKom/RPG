
                ifndef _CORE_MODULE_GRAPHICS_TILE_WORLD_GRAPHICS_PACK_1_
                define _CORE_MODULE_GRAPHICS_TILE_WORLD_GRAPHICS_PACK_1_
World:          incbin "Tile/World/Sprite/Compressed/Ground/Ground.pack.ar"
                display " - Ground.pack:\t\t\t\t\t", /A, World, " = busy [ ", /D, $ - World, " bytes  ]"
UI:
.Arrow          include "UI/Arrow/Include.inc"
                display " - World UI 'Arrow':\t\t\t\t\t", /A, UI.Arrow, " = busy [ ", /D, $ - UI.Arrow, " bytes  ]"
.World          include "UI/World/Include.inc"
                display " - World UI:\t\t\t\t\t\t", /A, .World, " = busy [ ", /D, $ - .World, " bytes  ]"
.Weapon         include "UI/Weapon/Include.inc"
                display " - Weapon UI:\t\t\t\t\t\t", /A, .Weapon, " = busy [ ", /D, $ - .Weapon, " bytes  ]"
.SettleFrame    include "UI/Settlement/Include.inc"
                display " - Settlement UI:\t\t\t\t\t", /A, .SettleFrame, " = busy [ ", /D, $ - .SettleFrame, " bytes  ]"
.MapFrame       include "UI/Map/Include.inc"
                display " - Map UI:\t\t\t\t\t\t", /A, .MapFrame, " = busy [ ", /D, $ - .MapFrame, " bytes  ]"
.Charecters     include "UI/Charecter/Include.inc"
                display " - Charecters UI:\t\t\t\t\t", /A, .Charecters, " = busy [ ", /D, $ - .Charecters, " bytes  ]"
.MapMarkers     include "UI/MapMarkers/Include.inc"
                display " - MapMarkers UI:\t\t\t\t\t", /A, .MapMarkers, " = busy [ ", /D, $ - .MapMarkers, " bytes  ]"
Cars:
.A              include "Car/A/Include.inc"
                display " - Car A:\t\t\t\t\t\t", /A, Cars.A, " = busy [ ", /D, $ - Cars.A, " bytes  ]"
.B              include "Car/B/Include.inc"
                display " - Car B:\t\t\t\t\t\t", /A, .B, " = busy [ ", /D, $ - .B, " bytes  ]"
Weapon:
.Mine           include "Weapon/Include.inc"
                display " - Weapon 'Mine':\t\t\t\t\t", /A, Weapon.Mine, " = busy [ ", /D, $ - Weapon.Mine, " bytes  ]"
Declas:         include "Tile/World/Sprite/Original/Decal/Include.inc"
                display " - Decals:\t\t\t\t\t\t", /A, Declas, " = busy [ ", /D, $ - Declas, " bytes  ]"
VFX:
.Dust           include "VFX/Dust/Include.inc"
                display " - Dust:\t\t\t\t\t\t", /A, VFX.Dust, " = busy [ ", /D, $ - VFX.Dust, " bytes  ]"
.Smoke          include "VFX/Smoke/Include.inc"
                display " - Smoke:\t\t\t\t\t\t", /A, .Smoke, " = busy [ ", /D, $ - .Smoke, " bytes  ]"
.Explosion      include "VFX/Explosion/Include.inc"
                display " - Explosion:\t\t\t\t\t\t", /A, .Explosion, " = busy [ ", /D, $ - .Explosion, " bytes  ]"
.MuzzleFlash    include "VFX/MuzzleFlash/Include.inc"
                display " - MuzzleFlash:\t\t\t\t\t", /A, .MuzzleFlash, " = busy [ ", /D, $ - .MuzzleFlash, " bytes  ]"

                endif ; ~ _CORE_MODULE_GRAPHICS_TILE_WORLD_GRAPHICS_PACK_1_
