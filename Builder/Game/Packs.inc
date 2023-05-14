
                ifndef _BUILDER_GAME_PACKS_
                define _BUILDER_GAME_PACKS_

                ; важен порядок инклудо, т.к. они в такой 
                ; последовательности загружаются в bootloader
                include "Pages/Pack 2.inc"
                include "Pages/Pack 5.inc"
                include "Pages/Pack 0.inc"
                include "Pages/Pack 1.inc"
                include "Pages/Pack 3.inc"
                include "Pages/Pack 4.inc"
                include "Pages/Pack 6.inc"

                endif ; ~ _BUILDER_GAME_PACKS_
