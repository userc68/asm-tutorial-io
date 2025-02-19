global _start 

section .bss 
  input1 resb 16

section .text
  dialogue1 db "INPUT: ", 0
  dialogue1_len equ $ - dialogue1

  dialogue2 db "YOU SAID: ", 10
  dialogue2_len equ $ - dialogue2

_start:
  mov rax, 1             
  mov rdi, 1             
  mov rsi, dialogue1     
  mov rdx, dialogue1_len 
  syscall                

  mov rax, 0             
  mov rdi, 0             
  mov rsi, input1        
  mov rdx, 16            
  syscall                

  mov rax, 1             
  mov rdi, 1             
  mov rsi, input1        
  mov rdx, 16            
  syscall                

  mov rax, 60            
  mov rdi, 0             
  syscall                
