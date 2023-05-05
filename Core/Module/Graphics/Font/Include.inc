
                ifndef _CORE_MODULE_GRAPHICS_FONT_INCLUDE_
                define _CORE_MODULE_GRAPHICS_FONT_INCLUDE_

                module Font
Begin           EQU $
                incbin "Core/Module/Graphics/Font/Original/ASCII_Table.bin"
                incbin "Core/Module/Graphics/Font/Original/ASCII.spr"
    
                display " - Font:\t\t\t\t\t\t", /A, Begin, " = busy [ ", /D, $ - Begin, " bytes  ]"

                endmodule

                endif ; ~_CORE_MODULE_GRAPHICS_FONT_INCLUDE_
