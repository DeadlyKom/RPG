
                ifndef _MODULE_GAME_RENDER_SORT_QUICKSORT_
                define _MODULE_GAME_RENDER_SORT_QUICKSORT_
; -----------------------------------------
; сортировка
; In:
; Out:
; Corrupt:
; Note:
;  не устойчив к прерыванию
; -----------------------------------------
Quicksort:      LD A, C
                OR A
                RET Z

                LD HL, SortBuffer
                LD B, C                                                         ; B - размер массива, C - количествой элементов в массиве
                LD C, #01

                ; инициализация
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

                ; чтение значения
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
                LD A, C
                DEC A
                ADD A, A
                LD L, A
                LD H, HIGH SortBuffer
                LD SP, HL

                ; i < size
                LD A, C
                CP B
                JP C, .Loop

                ; -1
                INC L
                INC L 
 
                RET

                endif ; ~_MODULE_GAME_RENDER_SORT_QUICKSORT_
