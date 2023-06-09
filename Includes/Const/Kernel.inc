
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
.Sprite         EQU Kernel.Memcpy.Sprite

; memory set
SafeFill:
.Screen         EQU Kernel.Memset.SafeFill_Screen
.b4096          EQU Kernel.Memset.SafeFill_4096
.b2048          EQU Kernel.Memset.SafeFill_2048
.b1024          EQU Kernel.Memset.SafeFill_1024
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

; initialize
Execute
.Core           EQU Kernel.Execute.Core                                         ; запуск инициализации игры
.Player         EQU Kernel.Execute.Player                                       ; запуск инициализации игрока
.Input          EQU Kernel.Execute.Input                                        ; запуск инициализации управления
.MainMenu       EQU Kernel.Execute.MainMenu                                     ; запуск главного меню
.PlayGame       EQU Kernel.Execute.PlayGame                                     ; запуск игры (первичный)
.Settlement     EQU Kernel.Execute.Settlement                                   ; запуск поселение
.Wasteland      EQU Kernel.Execute.Wasteland                                    ; запуск пустоши
.WastelandSpr   EQU Kernel.Execute.WastelandSpr                                 ; запуск генерация спрайтов для пустоши
.Map            EQU Kernel.Execute.Map                                          ; запуск карты

; tables
Table:
.ShiftFunc      EQU Kernel.Function.Table.Shift_LD
.NoShiftFunc    EQU Kernel.Function.Table.NoShift_LD
.ShiftOXRFunc   EQU Kernel.Function.Table_SR.Shift_OR_XOR
.NoShiftOXRFunc EQU Kernel.Function.Table_SR.NoShift_OR_XOR

; draw
Draw:
.World          EQU Kernel.World.Draw                                           ; отображение карты миры
.Minimap        EQU Kernel.World.Minimap                                        ; отображение миникарты
.Sprite         EQU Kernel.Sprite.Draw                                          ; отображение спрайта без атрибутов
.Object         EQU Kernel.Object.Draw                                          ; отображение объектов
.WorldArrow     EQU Kernel.Arrow.Update                                         ; обновление стрелки ближайшего врага на карте мира
.Line           EQU Kernel.DrawLine                                             ; отображение линии
.Char           EQU Kernel.DrawChar                                             ; отобразить символ
.String         EQU Kernel.DrawString                                           ; отобразить строку

.Prepare        EQU Kernel.Sprite.Prepare                                       ; подготовка спрайта перед выводм на экран
.Prepare.PosX   EQU Kernel.Sprite.Prepare.PositionX                             ; положение спрайта по горизонтали
.Prepare.PosY   EQU Kernel.Sprite.Prepare.PositionY                             ; положение спрайта по вертикали
.Prepare.SOx    EQU Kernel.Sprite.Prepare.SOx                                   ; смещение спрайта по горизонтали
.Prepare.SOy    EQU Kernel.Sprite.Prepare.SOy                                   ; смещение спрайта по вертикали
.Prepare.Size   EQU Kernel.Sprite.Prepare.SpriteSize                            ; размер спрайта (E - высота, D - ширина)

.AttrSprOne     EQU Kernel.Charboundary.DrawSpriteOne                           ; отрисовка спрайта с атрибутами
.AttrSprTwo     EQU Kernel.Charboundary.DrawSpriteTwo                           ; отрисовка спрайта с атрибутами (в 2х экранах)
.CharOne        EQU Kernel.Charboundary.DrawCharOne                             ; отрисовка знакоместа без атрибутов (в одном экране)
.AttrCharOne    EQU Kernel.Charboundary.DrawCharOne_A                           ; отрисовка знакоместа с атрибутами (в одном экране)
.AttrCharTwo    EQU Kernel.Charboundary.DrawCharTwo                             ; отрисовка знакоместа с атрибутами (в двух экранах)
.AttrStencilSpr EQU Kernel.Charboundary.DrawStencilSpr                          ; отрисовка спрайта с атрибутами

Convert:
.SetBaseScreen  EQU Kernel.Utils.SetBaseScreen                                  ; установка работы с основным экраном
.SetShadowScreen EQU Kernel.Utils.SetShadowScreen                               ; установка работы с теневым экраном
.CharToScreen   EQU Kernel.Utils.PixelAddressC
.PixelToScreen  EQU Kernel.Utils.PixelAddressP
.ToAttribute    EQU Kernel.Utils.PixelAttribute

; object
Object:
.GetSpriteInfo  EQU Kernel.Object.Pawn.GetSpriteInfo                            ; получить информацию о спрайте машины

; world map
World:
.Shake_X        EQU Kernel.World.Draw.Shake_X                                   ; тряска карты мира по горизонтали
.Shake_Y        EQU Kernel.World.Draw.Shake_Y                                   ; тряска карты мира по вертикали
.Shift_X        EQU Kernel.World.Draw.Shift_X                                   ; смещение карты мира по горизонтали
.Shift_Y        EQU Kernel.World.DrawColumn.Shift_Y                             ; смещение карты мира по вертикали

; input
Input:
.CheckKeyState  EQU Kernel.Input.CheckKeyState
.JumpKeys       EQU Kernel.Input.JumpKeys
.ArrayKeys      EQU Kernel.Input.JumpKeys.LastKey
.JumpHandlerKey EQU Kernel.Input.JumpHandlerKey
Kempston:
.Initialize     EQU Kernel.Kempston.Initialize                                  ; инициализация кемпстон джойстика
.CheckKeyState  EQU Kernel.Kempston.CheckKeyState
.GetPressedKey  EQU Kernel.Kempston.GetPressedKey
.WaitPressedKey EQU Kernel.Kempston.WaitPressedKey
.WaitReleasedKey EQU Kernel.Kempston.WaitReleasedKey                            ; ожидание отпускание ранее нажатой клавиши
.AnyKeyPressed  EQU Kernel.Kempston.AnyKeyPressed                               ; проверка нажатия либой клавиши
Keyboard:
.CheckKeyState  EQU Kernel.Keyboard.CheckKeyState
.GetPressedKey  EQU Kernel.Keyboard.GetPressedKey
.WaitPressedKey EQU Kernel.Keyboard.WaitPressedKey
.WaitReleasedKey EQU Kernel.Keyboard.WaitReleasedKey                            ; ожидание отпускание ранее нажатой клавиши
.AnyKeyPressed  EQU Kernel.Keyboard.AnyKeyPressed                               ; проверка нажатия либой клавиши
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

; cursor draw and logic
Cursor
.Draw           EQU Kernel.Cursor.Draw                                          ; отображение курсора
.Up             EQU Kernel.Cursor.Up                                            ; перемещение курсор выше на позицию
.Down           EQU Kernel.Cursor.Down                                          ; перемещение курсор ниже на позицию
.Prev           EQU Kernel.Cursor.Prev                                          ; изменение значения на предыдущее
.Next           EQU Kernel.Cursor.Next                                          ; изменение значения на следующее

; math
Math
.Rand8          EQU Kernel.Math.Rand8
.PopSeed        EQU Kernel.Math.PopSeed
.PushSeed       EQU Kernel.Math.PushSeed
.SetSeed16      EQU Kernel.Math.SetSeed16
.SetSeed32      EQU Kernel.Math.SetSeed32
.SetSeed80      EQU Kernel.Math.SetSeed80
.Lerp           EQU Kernel.Math.Lerp
.Clamp          EQU Kernel.Math.Clamp
.Sub32_32       EQU Kernel.Math.Sub32_32
.Mul16x8_16     EQU Kernel.Math.Mul16x8_16
.Mul16x8_24     EQU Kernel.Math.Mul16x8_24
.Mul32x8_40     EQU Kernel.Math.Mul32x8_40
.Div8x8         EQU Kernel.Math.Div8x8
.Div16x8_16     EQU Kernel.Math.Div16x8_16
.DivFix8x8      EQU Kernel.Math.DivFix8x8
.Atan           EQU Kernel.Math.Atan_Sector
.SinCos         EQU Kernel.Math.SinCos
.Cos            EQU Kernel.Math.Cos
.Sin            EQU Kernel.Math.Sin
.IntersectAABB  EQU Kernel.Math.IntersectAABB
.DistSquared    EQU Kernel.Math.DistSquared
.PerlinNoise2D  EQU Kernel.Math.PerlinNoise2D
.PN_Frequency   EQU Kernel.Math.Noise2D.Frequency
.PN_LocationX   EQU Kernel.Math.Noise2D.Location.X
.PN_LocationY   EQU Kernel.Math.Noise2D.Location.Y

; decompressor
Decompressor
.Forward        EQU Kernel.Decompressor.Forward
.Backward       EQU Kernel.Decompressor.Backward

; UI animation
UI
.CharTick       EQU Kernel.UI.Charecter.Tick                                    ; тик анимации персонажа
; AI
; AI
; .SetBTS_UNKNOW  EQU Kernel.AI.SetBTS_UNKNOW
; .SetBTS_RUNNING EQU Kernel.AI.SetBTS_RUNNING
; .SetBTS_FAILURE EQU Kernel.AI.SetBTS_FAILURE
; .SetBTS_SUCCESS EQU Kernel.AI.SetBTS_SUCCESS

; sound
SFX
.BEEP.Fail      EQU Kernel.SFX.BEEP.Fail                                        ; звуковой эффект ошибки

VFX
.Diagonal_In    EQU Kernel.VFX.Diagonal_In
.Diagonal_Out   EQU Kernel.VFX.Diagonal_Out

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

.ResetFadeout   EQU Kernel.Functions.ResetFadeout                               ; функция сброса и уход в затемнение
.ShadowScrcpy   EQU Kernel.Functions.ShadowScrcpy                               ; функция копирования в теневой экран
.BaseScrcpy     EQU Kernel.Functions.BaseScrcpy                                 ; функция копирования в основной экран

; utils
Utils
.Strcpy         EQU Kernel.Utils.String.Copy                                    ; копирование строки
.GetWidth       EQU Kernel.Utils.String.GetWidth                                ; длина строки в пикселях (нужно вкл страницу шрифтов)
.GetLength      EQU Kernel.Utils.String.GetLength                               ; длина строки
.GetStringID    EQU Kernel.Utils.String.GetStringID                             ; поиск строки в масиве по индексу
.ToString_8     EQU Kernel.Utils.String.B2D8                                    ; преобразовать 8-битное число в строку
.ToString_16    EQU Kernel.Utils.String.B2D16                                   ; преобразовать 16-битное число в строку
.StrBuffer      EQU Kernel.Utils.String.B2DBUF                                  ; буфер строки после преобразования чиста в строку
.TimeTick       EQU Kernel.Utils.Time.Tick                                      ; приращение счётчика времени
.SpriteParse    EQU Kernel.Utils.SpriteParse                                    ; парсинг структуры спрайта
.ClipRect       EQU Kernel.Utils.SetClipRect                                    ; установка отсечения видимой области
; debug
                ifdef _DEBUG
Console:
.DrawChar       EQU Kernel.Console.DrawChar
.DrawByte       EQU Kernel.Console.DrawByte
.DrawWord       EQU Kernel.Console.DrawWord
.DrawWordFrom   EQU Kernel.Console.DrawWordFromAdr
.DrawString     EQU Kernel.Console.DrawString
.SetCursor      EQU Kernel.Console.SetCursor
.SetScreenAdr   EQU Kernel.Console.SetScreenAdr
.SetAttribute   EQU Kernel.Console.SetAttribute
FPS_Counter:
.Tick           EQU Kernel.FPS_Counter.Tick
.Frame          EQU Kernel.FPS_Counter.Frame
.Render         EQU Kernel.FPS_Counter.Render

                ifdef SHOW_COLLISION_AABB
DebugDraw:
.AABB           EQU  Kernel.DrawAABB
                endif
                endif

                endif ; ~_BUILDER_KERNEL_
