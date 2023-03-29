
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

; generation
Generation:
.ScrAdr         EQU Kernel.Tables.ScrAdrGen                                     ; генерация адресов экрана (строк)      - перенести в страницу!
.PRNG_Gen       EQU Kernel.Tables.PRNG_Gen                                      ; генерация PRNG карты мира             - перенести в страницу!
.WorldSprite    EQU Kernel.Tables.WorldSpriteGen                                ; генерация спрайтов для карты мира     - перенести в страницу!

; draw
Draw:
.World          EQU Kernel.World.Draw                                           ; отображение карты миры
.Minimap        EQU Kernel.World.Minimap                                        ; отображение миникарты

Convert:
.CharToScreen   EQU Kernel.Utils.PixelAddressC
.PixelToScreen  EQU Kernel.Utils.PixelAddressP
.ToAttribute    EQU Kernel.Utils.PixelAttribute

; world map
World:
.Shake_X        EQU Kernel.World.Draw.Shake_X                                   ; тряска карты мира по горизонтали
.Shake_Y        EQU Kernel.World.Draw.Shake_Y                                   ; тряска карты мира по вертикали
.Shift_X        EQU Kernel.World.Draw.Shift_X                                   ; смещение карты мира по горизонтали
.Shift_Y        EQU Kernel.World.DrawColumn.Shift_Y                                   ; смещение карты мира по вертикали

Input:
.CheckKeyState  EQU Kernel.Input.CheckKeyState
.JumpKeys       EQU Kernel.Input.JumpKeys
.ArrayKeys      EQU Kernel.Input.JumpKeys.LastKey
Kempston:
.CheckKeyState  EQU Kernel.Kempston.CheckKeyState
Keyboard:
.CheckKeyState  EQU Kernel.Keyboard.CheckKeyState
.GetPressedKey  EQU Kernel.Keyboard.GetPressedKey
.WaitPressedKey EQU Kernel.Keyboard.WaitPressedKey
.WaitReleasedKey EQU Kernel.Keyboard.WaitReleasedKey                            ; ожидание отпускание ранее нажатой клавиши
.AnyKeyPressed  EQU Kernel.Keyboard.AnyKeyPressed                               ; проверка нажатия какая либо клавиши
Mouse:
.Initialize     EQU Kernel.Mouse.Initialize
.UpdateCursor   EQU Kernel.Mouse.UpdateCursor
.CheckKeyState  EQU Kernel.Mouse.CheckKeyState
.Position       EQU Kernel.Mouse.Position
.PositionX      EQU Kernel.Mouse.PositionX
.PositionY      EQU Kernel.Mouse.PositionY
.PositionFlag   EQU Kernel.Mouse.PositionFlag                                   ; если курсор не поменяет позицию, хранит #FF
.SVK_LBUTTON    EQU Kernel.Mouse.SVK_LBUTTON
.SVK_RBUTTON    EQU Kernel.Mouse.SVK_RBUTTON
.SVK_MBUTTON    EQU Kernel.Mouse.SVK_MBUTTON
; Cursor:
; .MoveUp         EQU Kernel.Input.Cursor.MoveUp
; .MoveDown       EQU Kernel.Input.Cursor.MoveDown
; .MoveLeft       EQU Kernel.Input.Cursor.MoveLeft
; .MoveRight      EQU Kernel.Input.Cursor.MoveRight

; math
Math
.Rand8          EQU Kernel.Math.Rand8
.SetSeed16      EQU Kernel.Math.SetSeed16
.Lerp           EQU Kernel.Math.Lerp
.Mul16x8_16     EQU Kernel.Math.Mul16x8_16
.Mul16x8_23     EQU Kernel.Math.Mul16x8_16
.Mul32x8_40     EQU Kernel.Math.Mul32x8_40
.PerlinNoise2D  EQU Kernel.Math.PerlinNoise2D
.PN_Frequency   EQU Kernel.Math.Noise2D.Frequency
.PN_LocationX   EQU Kernel.Math.Noise2D.Location.X
.PN_LocationY   EQU Kernel.Math.Noise2D.Location.Y


; decompressor
Decompressor
.Forward        EQU Kernel.Decompressor.Forward
.Backward       EQU Kernel.Decompressor.Backward

; load modules

; functions
Func
.Left.x8        EQU Kernel.Functions.NoShiftLeft.x8
.Left.x6        EQU Kernel.Functions.NoShiftLeft.x6
.Left.x4        EQU Kernel.Functions.NoShiftLeft.x4
.Left.x2        EQU Kernel.Functions.NoShiftLeft.x2
.Left.x0        EQU Kernel.Functions.NoShiftLeft.x0
.Center.x8      EQU Kernel.Functions.NoShiftCenter.x8
.Center.x6      EQU Kernel.Functions.NoShiftCenter.x6
.Center.x4      EQU Kernel.Functions.NoShiftCenter.x4
.Center.x2      EQU Kernel.Functions.NoShiftCenter.x2
.Center.x0      EQU Kernel.Functions.NoShiftCenter.x0
.Right.x8       EQU Kernel.Functions.NoShiftRight.x8
.Right.x6       EQU Kernel.Functions.NoShiftRight.x6
.Right.x4       EQU Kernel.Functions.NoShiftRight.x4
.Right.x2       EQU Kernel.Functions.NoShiftRight.x2
.Right.x0       EQU Kernel.Functions.NoShiftRight.x0

; tables

; debug
                ifdef _DEBUG
Console:
.DrawChar       EQU Kernel.Console.DrawChar
.DrawByte       EQU Kernel.Console.DrawByte
.DrawWord       EQU Kernel.Console.DrawWord
.DrawWordFrom   EQU Kernel.Console.DrawWordFromAdr
.SetCursor      EQU Kernel.Console.SetCursor
.SetScreenAdr   EQU Kernel.Console.SetScreenAdr
.SetAttribute   EQU Kernel.Console.SetAttribute
FPS_Counter:
.Tick           EQU Kernel.FPS_Counter.Tick
.Frame          EQU Kernel.FPS_Counter.Frame
.Render         EQU Kernel.FPS_Counter.Render
                endif

                endif ; ~_BUILDER_KERNEL_
