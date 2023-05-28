
                ifndef _BUILDER_PAGE_7_
                define _BUILDER_PAGE_7_

                module Page

                display "\'Page 7\':\t\t\t\t\t\t-------------------- [ ", /D, BankSize, " bytes ]\t [", /D, PAGE_7, "]\t ------------------------"

                display " - Shadow screen:\t\t\t\t\t", /A, MemBank_03_SCR, " = busy [ ", /D, ScreenSize, " bytes  ]"
                display " - World map sprite (tilepairs):\t\t\t", /A, Adr.WorldSpr, " = busy [ ", /D, Size.WorldSpr, " bytes  ]"
                display " - Tilepar tables:\t\t\t\t\t", /A, Adr.WorldTilepair, " = busy [ ", /D, Size.WorldTilepair, " bytes  ]"
                display " - World map sprite table (tilepairs):\t\t", /A, Adr.WorldSprTable, " = busy [ ", /D, Size.WorldSprTable, " bytes  ]"
                endmodule

                endif ; ~ _BUILDER_PAGE_7_

