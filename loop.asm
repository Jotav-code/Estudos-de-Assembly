.globl main 
.data  # la vem dados
mensagem: .asciiz "loopando\n" # declarando uma string
.text # indicando que agora vem texto
main:

	li $t0, 0 # vai ser o meu i do loop
	
	li $v0, 5
	syscall
	move $s0,$v0
	
	loop:
		beq $t0, $s0, FIM # enquando não forem iguais ele continua
		
		li $v0, 4
		la $a0, mensagem # exibe a mensagem 
		syscall
		
		li $v0, 1
		move $a0, $t0 # exibe o numero atual do loop
		syscall
		
		addi $t0, $t0,1
		
		j loop
		
	FIM:
		li $v0, 1
		move $a0, $t0 # exibe o numero atual do loop
		syscall
	
