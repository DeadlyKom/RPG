
                ifndef _CORE_MODULE_GRAPHICS_CHARECTER_INCLUDE_
                define _CORE_MODULE_GRAPHICS_CHARECTER_INCLUDE_

                module UI
                module Charecter

                ifdef _REBUILD
Charecter_0     EQU $
                incbin "Original/Charecter_0_0.spr"
                incbin "Original/Charecter_0_1.spr"
                incbin "Original/Charecter_0_2.spr"
                incbin "Original/Charecter_0_3.spr"
Charecter_0_    EQU $ - Charecter_0
                savebin "Core/Module/Graphics/UI/Charecter/Original/Charecter_0.pack", Charecter_0, Charecter_0_

Charecter_1     EQU $
                incbin "Original/Charecter_1_0.spr"
                incbin "Original/Charecter_1_1.spr"
                incbin "Original/Charecter_1_2.spr"
                incbin "Original/Charecter_1_3.spr"
Charecter_1_    EQU $ - Charecter_1
                savebin "Core/Module/Graphics/UI/Charecter/Original/Charecter_1.pack", Charecter_1, Charecter_1_

Charecter_2     EQU $
                incbin "Original/Charecter_2_0.spr"
                incbin "Original/Charecter_2_1.spr"
                incbin "Original/Charecter_2_2.spr"
                incbin "Original/Charecter_2_3.spr"
Charecter_2_    EQU $ - Charecter_2
                savebin "Core/Module/Graphics/UI/Charecter/Original/Charecter_2.pack", Charecter_2, Charecter_2_

Charecter_3     EQU $
                incbin "Original/Charecter_3_0.spr"
                incbin "Original/Charecter_3_1.spr"
                incbin "Original/Charecter_3_2.spr"
                incbin "Original/Charecter_3_3.spr"
Charecter_3_    EQU $ - Charecter_3
                savebin "Core/Module/Graphics/UI/Charecter/Original/Charecter_3.pack", Charecter_3, Charecter_3_

Charecter_4     EQU $
                incbin "Original/Charecter_4_0.spr"
                incbin "Original/Charecter_4_1.spr"
                incbin "Original/Charecter_4_2.spr"
                incbin "Original/Charecter_4_3.spr"
Charecter_4_    EQU $ - Charecter_4
                savebin "Core/Module/Graphics/UI/Charecter/Original/Charecter_4.pack", Charecter_4, Charecter_4_

                include "Compress.inc"
                else
_0              incbin "Compressed/Charecter_0.pack.ar"
_1              incbin "Compressed/Charecter_1.pack.ar"
_2              incbin "Compressed/Charecter_2.pack.ar"
_3              incbin "Compressed/Charecter_3.pack.ar"
_4              incbin "Compressed/Charecter_4.pack.ar"

                endif

                endmodule
                endmodule

                endif ; ~ _CORE_MODULE_GRAPHICS_CHARECTER_INCLUDE_
