
                ifndef _BUILDER_KERNEL_PACK_
                define _BUILDER_KERNEL_PACK_

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
                ; include "Core/Module/Memory/MemcpySprite.asm"

                ; generation
                include "Core/Module/Table/PRNG_Gen.asm"
                include "Core/Module/Table/ScrAdrGen.asm"
                include "Core/Module/Table/WorldSpriteGen.asm"

                ; draw world map
                include "Core/Module/Draw/World/Draw.asm"
                include "Core/Module/Draw/World/DrawColumn.asm"
                include "Core/Module/Draw/World/Functions/Include.inc"

                ; decompressor
                include "Core/Module/Decompressor/Forward.asm"
                include "Core/Module/Decompressor/Backward.asm"

                ; math
                include "Core/Module/Math/Lerp.asm"
                include "Core/Module/Math/RNG/Rand8.asm"
                include "Core/Module/Math/Mul/16x8_16.asm"
                include "Core/Module/Math/Mul/16x8_24.asm"
                include "Core/Module/Math/Mul/32x8_40.asm"
                include "Core/Module/Math/PerlinNoise/Include.inc"

                ; input
                include "Core/Module/Input/Include.inc"

                ; utils
                include "Core/Module/Draw/Utils/PixelAddress.asm"
                include "Core/Module/Draw/Utils/PixelAttribute.asm"

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

                endif ; ~ _BUILDER_KERNEL_PACK_
