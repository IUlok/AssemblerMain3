include io.asm
.model small
.stack 100
.data
  msg db "Enter array: ", 0Ah, 0Dh, '$'
.code 
public podprog
podprog proc far
      push bp
      mov bp, sp
      push ds
      push bx
      mov ah, 9
      lea dx, msg
      int 21h
      mov si, 0
      mov cx, bx
starting:
      mov ah,01h
      int 21h
      cmp al,' '
      jne ifelse
      jmp cycle
ifelse:
      mov ds:[si],al
      inc si
cycle:
      loop starting
      mov al, '$'
      mov ds:[si], al
      newline
      pop bx
      pop ds
      pop bp
      ret
podprog endp
end
