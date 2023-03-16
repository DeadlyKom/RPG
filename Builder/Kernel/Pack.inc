
                ifndef _BUILDER_KERNEL_PACK_
                define _BUILDER_KERNEL_PACK_

                MMU 2, 2                                                        ; 2 bank, 2 page
                ORG Adr.Interrupt
                module Kernel

                display "\'Kernel\' :\t\t\t\t\t\t-------------------- [ ", /D, Size, " bytes [2]\t---------------------------------"

Begin:          EQU $
                ; interrupt
                include "Core/Module/Interrupt/Include.inc"

                ; memory
                include "Core/Module/Memory/Switch.asm"
                include "Core/Module/Memory/MemSet.asm"
                include "Core/Module/Memory/MemcpyPages.asm"
                include "Core/Module/Memory/MemcpyFastLDIR.asm"
                ; include "Core/Module/Memory/MemcpySprite.asm"

Size:           EQU $ - Begin

                savetap TAP_FILENAME, HEADLESS, Begin, Size

                endmodule

                endif ; ~ _BUILDER_KERNEL_PACK_
