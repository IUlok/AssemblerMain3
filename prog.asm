Extrn podprog: Far                                  ; Указание внешнего имени дальнего типа (Другая программа)
include io.asm                                      ; 
.model small                                        ;
.stack 100                                          ; Начало сегмента стека
.data                                               ; Начало сегмента данных
  array db 100 dup(?)                               ; Массив символов
  x dw ?                                            ;
  msg1 db "Enter size of array: ", 0Ah, 0Dh, '$'    ; Строка с текстом
  msg db "Enter array: ", 0Ah, 0Dh, '$'             ; Строка с текстом
.code                                               ; Начало сегмента кода
.startup                                            ;
start:                                              ;
      mov ah, 9                                     ;]
      lea dx, msg1                                  ;]- Вывод строки msg1
      int 21h                                       ;]
      InInt x                                       ; Ввод длины строки в регистр cx
      mov cx, x                                     ;
      mov ah, 9                                     ;]
      lea dx, msg                                   ;]- Вывод сообщения msg
      int 21h                                       ;]
      mov si, 0                                     ; Обнуление счетчика si, отвечающего за индекс элемента строки
starting:                                           ; Метка starting
      mov ah,01h                                    ; ]- Прерывание для считывания символа с клавиатуры
      int 21h                                       ; ]
      mov array[si],al                              ; Запись введенного символа в массив по текущему индексу
      inc si                                        ; Увеличение счетчика индекса массива
      loop starting                                 ; Новая итерация цикла
      mov al, '$'                                   ; Запись символа конца строки в al
      push x                                        ; Перемещение операнда bx в стек, значение регистра уменьшено на 4, адрес возврата записан в bp
      mov dx, offset array                          ;
      push dx                                       ;
      call podprog                                  ; Вызов подпрограммы
      mov ah, 9                                     ;]
      lea dx, [bx]                                  ;]- Вывод строки без пробелов на экран
      int 21h                                       ;]
      .exit 0                                       ;
end                                                 ;
