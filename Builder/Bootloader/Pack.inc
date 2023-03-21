
                ifndef _BUILDER_BOOTLOADER_PACK_
                define _BUILDER_BOOTLOADER_PACK_

                MMU 1, 5                                                        ; 1 bank, 5 page
                ORG #5CCB
                module Bootloader

                display "\'Bootloader\':\t\t\t\t\t\t-------------------------------------------------------------------------"
Begin:          EQU $
                include "Basic.asm"
Size:           EQU $ - Begin

                ifndef _DEBUG
                savetap TAP_FILENAME, BASIC, "RPG", Begin, Size, 10
                endif

                endmodule

                endif ; ~ _BUILDER_BOOTLOADER_PACK_

