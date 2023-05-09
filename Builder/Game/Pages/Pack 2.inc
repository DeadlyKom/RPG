
                ifndef _BUILDER_PACK_2_
                define _BUILDER_PACK_2_

                MMU 2, Page.Module.Kernel                                       ; 1 bank, Page.Module.Kernel (2) page
                ORG Adr.Interrupt
                module Kernel

                display "\'Kernel\':\t\t\t\t\t\t-------------------- [ ", /D, Size, " bytes ]\t [", /D, Page.Module.Kernel, "]\t ------------------------"
Begin:          EQU $
                ; interrupt
                include "Core/Module/Interrupt/Include.inc"

                ; memory
                include "Core/Module/Memory/Switch.asm"
                include "Core/Module/Memory/MemSet.asm"
                include "Core/Module/Memory/MemcpyPages.asm"
                include "Core/Module/Memory/MemcpyFastLDIR.asm"
                include "Core/Module/Memory/MemcpySprite.asm"

                ; execute
                include "Core/Module/Game/Initialize/Core/Include.inc"
                include "Core/Module/Game/Initialize/MainMenu/Include.inc"
                include "Core/Module/Game/Initialize/PlayGame/Include.inc"
                include "Core/Module/Game/Initialize/Settlement/Include.inc"

                ; draw world map
                include "Core/Module/Draw/World/Draw.asm"
                include "Core/Module/Draw/World/DrawColumn.asm"
                include "Core/Module/Draw/World/Functions/Include.inc"
                include "Core/Module/Draw/World/Minimap.asm"
                ; include "Core/Module/Draw/World/Arrow/Include.inc"              ; ToDo перенести в страницу!

                ; draw sprite
                include "Core/Module/Draw/Sprite/Include.inc"
                include "Core/Module/Draw/Sprite/Functions/Include.inc"
                ; include "Core/Module/Draw/Object/Include.inc"                   ; ToDo перенести в страницу!

                ; draw attribute
                include "Core/Module/Draw/Charboundary/DrawSprite.asm"
                include "Core/Module/Draw/Charboundary/DrawCharboundary.asm"
                include "Core/Module/Draw/Charboundary/DrawStencilSprite.asm"

                ; draw line
                include "Core/Module/Utils/Debug/DrawLine.asm"

                ; decompressor
                include "Core/Module/Decompressor/Forward.asm"
                include "Core/Module/Decompressor/Backward.asm"

                ; math
                include "Core/Module/Math/Lerp.asm"
                include "Core/Module/Math/RNG/Rand8.asm"
                include "Core/Module/Math/Mul/16x8_16.asm"
                include "Core/Module/Math/Mul/16x8_24.asm"
                include "Core/Module/Math/Mul/32x8_40.asm"
                include "Core/Module/Math/Div/Div8x8.asm"
                include "Core/Module/Math/Atan/Sector.asm"
                include "Core/Module/Math/PerlinNoise/Include.inc"
                include "Core/Module/Math/Sqrt/DistSquared.asm"
                include "Core/Module/Math/BoundVolume/IntersectsAABB_vs_AABB.asm"

                ; input
                include "Core/Module/Input/Include.inc"

                ; utils
                include "Core/Module/Draw/Utils/PixelAddress.asm"
                include "Core/Module/Draw/Utils/PixelAttribute.asm"

                ; AI
                include "Core/Module/AI/Include.inc"

                ; SFX
                include "Core/Module/SFX/Include.inc"

                ; VFX
                include "Core/Module/VFX/Include.inc"

                ; utils
                include "Core/Module/Utils/ConvertNumberToString.asm"

                ; object
                ; include "Core/Module/Object/Initialize/Include.inc"             ; ToDo перенести в страницу!
                ; include "Core/Module/Object/Damage/Include.inc"                 ; ToDo перенести в страницу!
                ; include "Core/Module/Game/Object/Include.inc"                   ; ToDo перенести в страницу!

                ; debug
                ifdef _DEBUG
                include "Core/Module/Utils/Debug/Console.asm"
                include "Core/Module/Utils/Debug/FPS_Counter.asm"
                endif

Size:           EQU $ - Begin

                ifndef _DEBUG
                savetap TAP_FILENAME, HEADLESS, Begin, Size
                endif

                endmodule

                endif ; ~ _BUILDER_PACK_2_