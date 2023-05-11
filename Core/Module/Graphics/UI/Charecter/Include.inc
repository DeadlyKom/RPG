
                ifndef _CORE_MODULE_GRAPHICS_CHARECTER_INCLUDE_
                define _CORE_MODULE_GRAPHICS_CHARECTER_INCLUDE_

                module UI
                module Charecter

                ifdef _REBUILD
_0              EQU $
                incbin "Original/Charecter_0_0.spr"
                incbin "Original/Charecter_0_1.spr"
                incbin "Original/Charecter_0_2.spr"
                incbin "Original/Charecter_0_3.spr"
_0_             EQU $ - _0
                savebin "Core/Module/Graphics/UI/Charecter/Original/Charecter_0.pack", _0, _0_

_1              EQU $
                incbin "Original/Charecter_1_0.spr"
                incbin "Original/Charecter_1_1.spr"
                incbin "Original/Charecter_1_2.spr"
                incbin "Original/Charecter_1_3.spr"
_1_             EQU $ - _1
                savebin "Core/Module/Graphics/UI/Charecter/Original/Charecter_1.pack", _1, _1_

_2              EQU $
                incbin "Original/Charecter_2_0.spr"
                incbin "Original/Charecter_2_1.spr"
                incbin "Original/Charecter_2_2.spr"
                incbin "Original/Charecter_2_3.spr"
_2_             EQU $ - _2
                savebin "Core/Module/Graphics/UI/Charecter/Original/Charecter_2.pack", _2, _2_

_3              EQU $
                incbin "Original/Charecter_3_0.spr"
                incbin "Original/Charecter_3_1.spr"
                incbin "Original/Charecter_3_2.spr"
                incbin "Original/Charecter_3_3.spr"
_3_             EQU $ - _3
                savebin "Core/Module/Graphics/UI/Charecter/Original/Charecter_3.pack", _3, _3_

_4              EQU $
                incbin "Original/Charecter_4_0.spr"
                incbin "Original/Charecter_4_1.spr"
                incbin "Original/Charecter_4_2.spr"
                incbin "Original/Charecter_4_3.spr"
_4_             EQU $ - _4
                savebin "Core/Module/Graphics/UI/Charecter/Original/Charecter_4.pack", _4, _4_

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
