
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

; generate
Generate:
.World          EQU Kernel.Execute.Gen_World                                    ; запуск генерации мира
; .WorldSprite    EQU Kernel.Tables.Gen_WorldSpr                                  ; генерация спрайтов для карты мира     ToDo перенести в страницу!

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
; .Object         EQU Kernel.Object.Draw                                          ; отображение объектов                  ToDo перенести в страницу!
; .WorldArrow     EQU Kernel.Arrow.Update                                         ; обновление стрелки ближайшего врага на карте мира ToDo перенести в страницу!
.Line           EQU Kernel.DrawLine                                             ; отображение линии

.Prepare        EQU Kernel.Sprite.Prepare                                       ; подготовка спрайта перед выводм на экран
.Prepare.PosX   EQU Kernel.Sprite.Prepare.PositionX                             ; положение спрайта по горизонтали
.Prepare.PosY   EQU Kernel.Sprite.Prepare.PositionY                             ; положение спрайта по вертикали
.Prepare.SOx    EQU Kernel.Sprite.Prepare.SOx                                   ; смещение спрайта по горизонтали
.Prepare.SOy    EQU Kernel.Sprite.Prepare.SOy                                   ; смещение спрайта по вертикали
.Prepare.Size   EQU Kernel.Sprite.Prepare.SpriteSize                            ; размер спрайта (E - высота, D - ширина)

.AttrSprOne     EQU Kernel.Charboundary.DrawSpriteOne                           ; отрисовка спрайта с атрибутами
.AttrSprTwo     EQU Kernel.Charboundary.DrawSpriteTwo                           ; отрисовка спрайта с атрибутами (в 2х экранах)
.AttrCharOne    EQU Kernel.Charboundary.DrawCharOne                             ; отрисовка знакоместа с атрибутами (в одном экране)
.AttrCharTwo    EQU Kernel.Charboundary.DrawCharTwo                             ; отрисовка знакоместа с атрибутами (в двух экранах)
.AttrStencilSpr EQU Kernel.Charboundary.DrawStencilSpr                          ; отрисовка спрайта с атрибутами

Convert:
.CharToScreen   EQU Kernel.Utils.PixelAddressC
.PixelToScreen  EQU Kernel.Utils.PixelAddressP
.ToAttribute    EQU Kernel.Utils.PixelAttribute

; object
; Object:
; .Tick           EQU Kernel.Object.Tick                                          ; обработка тика объектов
; .Collision      EQU Kernel.Object.Collision.Handler                             ; обработка коллизии
; .Spawn_Dust     EQU Kernel.Object.Player.Spawn_Dust                             ; спавн пыли
; .Spawn_Mine     EQU Kernel.Object.Player.Spawn_Mine                             ; спавн мины
; .Spawn_Explosion EQU Kernel.Object.Player.Spawn_Explosion                       ; спавн взрыва
; .ApplySpeed     EQU Kernel.Object.Player.Rotation.ApplySpeed                    ; применить скорость
; .ApplyVelocity  EQU Kernel.Object.Update.Velocity                               ; применить вектор скорости
; .ApplyDecel     EQU Kernel.Object.Player.Deceleration                           ; применить торможение
; .GetSpriteInfo  EQU Kernel.Object.Pawn.GetSpriteInfo                            ; получить информацию о спрайте машины
; .Remove         EQU Kernel.Object.Utils.Remove                                  ; удаление объекта
; .DeltaPosition  EQU Kernel.Object.Utils.DeltaPosition                           ; расчёт дельт значений между двумя объектами

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

; math
Math
.Rand8          EQU Kernel.Math.Rand8
.PopSeed        EQU Kernel.Math.PopSeed
.PushSeed       EQU Kernel.Math.PushSeed
.SetSeed16      EQU Kernel.Math.SetSeed16
.SetSeed80      EQU Kernel.Math.SetSeed80
.Lerp           EQU Kernel.Math.Lerp
.Mul16x8_16     EQU Kernel.Math.Mul16x8_16
.Mul16x8_24     EQU Kernel.Math.Mul16x8_24
.Mul32x8_40     EQU Kernel.Math.Mul32x8_40
.Div8x8         EQU Kernel.Math.Div8x8
.Atan           EQU Kernel.Math.Atan_Sector
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

; AI
AI
.SetBTS_UNKNOW  EQU Kernel.AI.SetBTS_UNKNOW
.SetBTS_RUNNING EQU Kernel.AI.SetBTS_RUNNING
.SetBTS_FAILURE EQU Kernel.AI.SetBTS_FAILURE
.SetBTS_SUCCESS EQU Kernel.AI.SetBTS_SUCCESS

; sound
SFX
.BEEP.Fail      EQU Kernel.SFX.BEEP.Fail                                        ; звуковой эффект ошибки

VFX
.Diagonal       EQU Kernel.VFX.Diagonal
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

; .InitObject     EQU Kernel.Initialize.Object                                    ; инициализация работы с объектами      ToDo перенести в страницу!
; .WorldPosition  EQU Kernel.Initialize.WorldPosition                             ; привести к мировой позиции            ToDo перенести в страницу!
; .SpawnObject    EQU Kernel.Initialize.Spawn                                     ; спавн объекта в мире                  ToDo перенести в страницу!
; .ApplyVehicle   EQU Kernel.Damage.ApplyVehicle                                  ; нанести урон машине игрока            ToDo перенести в страницу!
; .ApplyExplosion EQU Kernel.Damage.ApplyExplosion                                ; нанести урон машине игрока            ToDo перенести в страницу!

; utils
Utils
.Strcpy         EQU Kernel.Utils.String.Copy                                    ; копирование строки
.GetWidth       EQU Kernel.Utils.String.GetWidth                                ; длина строки в пикселях (нужно вкл страницу шрифтов)
.GetLength      EQU Kernel.Utils.String.GetLength                               ; длина строки
.GetStringID    EQU Kernel.Utils.String.GetStringID                             ; поиск строки в масиве по индексу
.ToString_8     EQU Kernel.Utils.String.B2D8                                    ; преобразовать 8-битное число в строку
.ToString_16    EQU Kernel.Utils.String.B2D16                                   ; преобразовать 16-битное число в строку
.StrBuffer      EQU Kernel.Utils.String.B2DBUF                                  ; буфер строки после преобразования чиста в строку
.TimeTick       EQU  Kernel.Utils.Time.Tick                                     ; приращение счётчика времени

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
                endif

                endif ; ~_BUILDER_KERNEL_
