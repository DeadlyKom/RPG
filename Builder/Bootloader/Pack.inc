
                ifndef _BUILDER_BOOTLOADER_PACK_
                define _BUILDER_BOOTLOADER_PACK_

                MMU 1, 5                                                        ; 1 bank, 5 page
                ORG #4000
                module Bootloader

                display "\'Bootloader\' :\t\t\t\t\t-------------------------------------------------------------------------"
Begin:          EQU $
                include "Basic.asm"
Size:           EQU $ - Begin

                savetap TAP_FILENAME, BASIC, "RPG", Begin, Size, 10

                endmodule

                endif ; ~ _BUILDER_BOOTLOADER_PACK_

