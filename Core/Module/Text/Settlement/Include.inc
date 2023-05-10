
                ifndef _CORE_MODULE_TEXT_SETTLEMENT_INCLUDE_
                define _CORE_MODULE_TEXT_SETTLEMENT_INCLUDE_

                module Text

                ifdef _REBUILD
BeginSettle
                include "Original/Adjective.inc"
                include "Original/Noun.inc"
SizeSettle      EQU $ - BeginSettle

                savebin "Core/Module/Text/Settlement/Original/SettlementText.pack", BeginSettle, SizeSettle
                include "Compress.inc"
                else
BeginSettle
                incbin "Core/Module/Text/Settlement/Compressed/SettlementText.pack.ar"
SizeSettle      EQU $ - BeginSettle

                endif

                display " - Text 'Settlement':\t\t\t\t\t", /A, BeginSettle, " = busy [ ", /D, SizeSettle, " bytes  ]"

                endmodule

                endif ; ~ _CORE_MODULE_TEXT_SETTLEMENT_INCLUDE_
