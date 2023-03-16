
                ifndef _MACRO_INCLUDE_
                define _MACRO_INCLUDE_

                include "Basic.inc"
                ; include "Screen.inc"
                include "Memory.inc"
                include "Interrupt.inc"

                ifdef _DEBUG
                include "Debug.inc"
                endif

                endif ; ~_MACRO_INCLUDE_
