
                ifndef _BUILDER_KERNEL_
                define _BUILDER_KERNEL_
; memory switch page
SetPage         EQU Kernel.Memory.SetPage
SetPage0        EQU Kernel.Memory.SetPage0
SetPage1        EQU Kernel.Memory.SetPage1
SetPage3        EQU Kernel.Memory.SetPage3
SetPage4        EQU Kernel.Memory.SetPage4
SetPage5        EQU Kernel.Memory.SetPage5
SetPage6        EQU Kernel.Memory.SetPage6
SetPage7        EQU Kernel.Memory.SetPage7

Screen:
.FromPageC000   EQU Kernel.Memory.ScrFromPageC000                               ; установка экрана расположенного в #C000
.SetPageBase    EQU Kernel.Memory.ScrPageToC000                                 ; установка страницы видимого экрана
.SetPageShadow  EQU Kernel.Memory.ScrPageToC000_                                ; установка страницы невидимого экрана
.Swap           EQU Kernel.Memory.SwapScreens                                   ; переключение экранов
.ShowBase       EQU Kernel.Memory.ShowBaseScreen                                ; отображение базового экрана
.ShowShadow     EQU Kernel.Memory.ShowShadowScreen                              ; отображение теневого экрана

Memcpy:
.Pages          EQU Kernel.Memcpy.Pages
.FastLDIR       EQU Kernel.Memcpy.FastLDIR
; .Sprite         EQU Kernel.Memcpy.Sprite

; memory set
SafeFill:
.Screen         EQU Kernel.Memset.SafeFill_Screen
.b4096          EQU Kernel.Memset.SafeFill_4096
.b2048          EQU Kernel.Memset.SafeFill_2048
.b768           EQU Kernel.Memset.SafeFill_768
.b256           EQU Kernel.Memset.SafeFill_256
.b192           EQU Kernel.Memset.SafeFill_192
.b128           EQU Kernel.Memset.SafeFill_128
.b32            EQU Kernel.Memset.SafeFill_32

; interrupt
RestoreRegister EQU Kernel.Interrupt.Handler.RestoreRegister
UserInterrupt   EQU Kernel.Interrupt.Handler.UserInterrupt
Interrupt_RET   EQU Kernel.Interrupt.Handler.RET
ReturnAddress   EQU Kernel.Interrupt.Handler.ReturnAddress
TickCounterRef  EQU Kernel.Interrupt.Handler.TickCounterPtr                     ; счётчик тиков 1/50

; input

; math

; decompressor

; draw 

; load modules

; functions

; tables

; debug
                ifdef _DEBUG

                endif

                endif ; ~_BUILDER_KERNEL_
