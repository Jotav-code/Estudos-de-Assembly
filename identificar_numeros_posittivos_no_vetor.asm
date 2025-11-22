.globl main
.data
msg_execucao: .asciiz "Contando valores positivos…\n" #declarando variavel ded mensagem
vetor: .word -5, 4, 8, 20 , -4, -19, -3 # declarando meu vetor
.text
main:

	li $s0, 0 # Nosso contador, vai contar quantos número positivos temos
	li $t0, 0 # Vai ser o nosso 'i'
	la $s1, vetor # carregando o endereço do vetor
	
	li $v0, 4
	la $a0, msg_execucao
	syscall
	
	loop:
		beq $t0 , 7, fim # se t0 for igual a 6, da um jump para fim
		
		add $t1, $t0, $zero 
		# carregando nosso i no registrador para usar para acessar nosso vetor
		mul $t1, $t1, 4
		#multiplicando nosso indice por 4, pois nosso vetor é composto por int de 4 byttes
		add $t1, $t1, $s1
		#somando com o endereço para acessar a posição no vetor
		lw $t2, 0($t1)
		#carregando o valor em $t2
		
		blt $t2, 0, SIM
		
		addi $s0, $s0,1 
		
		j ENDIF
		
		SIM:
		
		ENDIF:
		
		addi $t0, $t0, 1
		j loop
	fim:
	
	li $v0, 1
	move $a0, $s0
	syscall
	
	
		
		
		