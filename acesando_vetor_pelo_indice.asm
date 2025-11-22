.globl main

.data

c: .word 3,2,5,6,7,8,40

.text

main:
 li $s1, 30 #carrego o valor 30 na no registrador 
 la $s2, c #carrego o endereço de memoria de c
 
 li $t0, 1
 sll $t0, $t0, 2 # damos um shift a esquerda, que é o mesmo que multiplicar por 4
 		# e fazemos isso porque um inteiro vale 4 bytes
 add $t0, $t0, $s2 #somando com c para acessar o indice
 
 lw $t1, 0($t0) #aqui estamos carregando o valor do indice 
 
 add $t1, $t1, $s1
 
 sw $t1, 0($t0)
 
 move $a0, $t1
 
 li $v0, 1
 syscall
 
 li $a0, 10
 li $v0, 11
 syscall
 
 li $t3, 1
 mul $t3, $t3, 4
 
 add $t3, $t3, $s2
 
 lw $a0, 0($t3)
 
 li $v0, 1
 syscall 
 
 
 
 
 
 
 