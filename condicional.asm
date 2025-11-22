.globl main

.data

hello: .asciiz "hello world, o resultado é esse\n"

.text
main:

	li $v0 , 5
	syscall
	move $s0, $v0
	
	li $v0 , 5
	syscall
	move $s1, $v0
	
	blt $s0, $s1, sim
	
	li $v0, 4
	la $a0, hello
	syscall
	
	li $v0, 1
	move $a0, $s0
	syscall
	
	j ENDIF
	
	sim:
	
	li $v0, 4
	la $a0, hello
	syscall
	
	li $v0, 1
	move $a0, $s1
	syscall
	
	ENDIF:
	
	
	