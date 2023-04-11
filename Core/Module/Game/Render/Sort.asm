
                ifndef _MODULE_GAME_RENDER_SORT_OBJECTS_
                define _MODULE_GAME_RENDER_SORT_OBJECTS_
; -----------------------------------------
; сортировка объектов отображения
; In:
; Out:
; Corrupt:
; Note:
;  прерывание небезопасеный
; -----------------------------------------
Sort:           ; количество обрабатываемых объектов
                LD A, (GameState.Objects)                                       ; количество элементов в массиве объектов
                OR A
                JR Z, .Set                                                      ; переход, если массив пуст
                EX AF, AF'
                 
                ; инициализация
                SET_PAGE_OBJECT                                                 ; включить страницу работы с объектами

                LD (.ContainerSP), SP
                
                LD HL, SortBuffer
                LD DE, Adr.Object; + FObjectDecal.Position.Y                    ; стартовый адрес обрабатываемого объекта
                LD BC, #0100                                                    ; B - размер массива, C - количествой элементов в массиве
                
                EX AF, AF'
.ObjectLoop     LD (.ObjectCounter), A
.ObjectLoop_    ; проверка валидности элемента
                LD A, (DE)
                CP OBJECT_EMPTY_ELEMENT
                JR Z, .NextObject

                ; -----------------------------------------
                ; копирование адреса объекта
                INC E
                LD (HL), E
                DEC E
                INC L
                LD (HL), D
                INC L

                ; прверка что массив увеличился и больше 1
                LD A, B
                ADD A, C
                DEC A
                JR Z, .Skip                                                     ; переход, если 1 элемент в массиве
                INC A
                LD B, A

                ; HL - адрес на первый неотсортированный элемент
                ; С  - количествой элементов в массиве
                LD A, C
                INC C
                OR A
                JR Z, .FirstSort                                                ; переход, если это первые элементы в массиве
                DEC L
                DEC L
                DEC L
                DEC L
                DEC C

.FirstSort      ; инициализация
                LD SP, HL
                LD A, C
                INC A
                EX AF, AF'

                ; s     = B  - размер массива
                ; i     = C  - текущий элемент
                ; j     = A' - следующий элемент
                ; a[]   = SP - указатель на массив
                ;
                ; while (i < s)
                ; {
                ;     if (a[i-1] <= a[i])
                ;     {
                ;         i=j;
                ;         j++;
                ;     }
                ;     else
                ;     {
                ;         ex a[i], a[i-1];
                ;         if (--i == 0)
                ;         {
                ;             i=j;
                ;             j++;
                ;         }
                ;     }
                ; }

.Loop           ; SP - [i-1]

                ; элемент [i-1]
                POP HL
                LD E, (HL)
                INC L
                LD D, (HL)

                ; элемент [i]
                POP HL
                PUSH HL

                ; чтение
                LD A, (HL)
                INC L
                LD H, (HL)
                LD L, A

                ; проверка [i] >= [i-1]
                OR A
                SBC HL, DE
                JR NC, .Next    ; i = j; j++

                ; меняем местами адреса
                DEC SP
                DEC SP
                POP HL
                EX (SP), HL
                PUSH HL
                DEC SP
                DEC SP

                ; i--; if (i == 0)
                DEC C
                JR NZ, .Loop

.Next           ; i = j, j++
                EX AF, AF'
                LD C, A
                INC A
                EX AF, AF'

                ; 
                LD L, C
                DEC L
                LD H, #00
                ADD HL, HL
                LD DE, SortBuffer
                ADD HL, DE
                LD SP, HL

                ; i < size
                LD A, C
                CP B
                JP C, .Loop

                ; -1
                INC HL
                INC HL

.Skip           INC C
                ; -----------------------------------------

                ; следующий элемент
                LD A, E
                ADD A, OBJECT_SIZE
                LD E, A
                ADC A, D
                SUB E
                LD D, A

                ; уменьшение счётчика элементов
.ObjectCounter  EQU $+1
                LD A, #00
                DEC A
                JR NZ, .ObjectLoop

.ContainerSP    EQU $+1
                LD SP, #0000

                LD A, B
.Set            LD (Draw.Num), A
                RET

.NextObject     ; следующий элемент
                LD A, E
                ADD A, OBJECT_SIZE
                LD E, A
                ADC A, D
                SUB E
                LD D, A
                JR .ObjectLoop_

                endif ; ~_MODULE_GAME_RENDER_SORT_OBJECTS_
