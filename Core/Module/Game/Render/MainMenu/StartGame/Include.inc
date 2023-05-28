
                ifndef _MODULE_GAME_RENDER_MAIN_MENU_START_GAME_INCLUDE_
                define _MODULE_GAME_RENDER_MAIN_MENU_START_GAME_INCLUDE_

                module StartGame
MENU_COLUMN_A   EQU #10
MENU_COLUMN_B   EQU #A0
MENU_ROW        EQU #23
HEIGHT          EQU 10                                                          ; высота (в пикселях)

                include "Draw.asm"
                include "DisplayClimate.asm"
                include "DisplayMapSize.asm"
                include "DisplayDifficulty.asm"
                include "DisplayKeyGeneration.asm"

                module Text
Begin
                include "Core/Module/Text/Settlement/Original/StartGame.inc"    ; начало игры
Clear           BYTE "^^^^^^^^^\0"
Size            EQU $ - Begin

                display " - Text 'Start Game':\t\t\t\t\t", /A, Begin, " = busy [ ", /D, Size, " bytes  ]"

                endmodule
                endmodule

                endif ; ~_MODULE_GAME_RENDER_MAIN_MENU_START_GAME_INCLUDE_
