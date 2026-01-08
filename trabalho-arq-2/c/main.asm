.globl main
.data
msg_cliente: .asciiz "Cliente: \n"

msg_saldo_insuficiente: .asciiz "Saldo insuficiente \n"

msg_saque_realizado: .asciiz "Saque realizado \n"

msg_deposito_realizado: .asciiz "Deposito realizado \n"

msg_cliente_nao_existe: .asciiz "Cliente não existe \n "

msg_do_painel: .asciiz "\n1-Depositar  2-Sacar  3-Estatisticas  4-Sair\n"

msg_quantidade_de_clientes: .asciiz "Quantidade de clientes: \n"

msg_saldo_inicial_do_cliente: .asciiz "Saldo inicial do cliente \n"

msg_valor: .asciiz "Valor: \n"

msg_total_no_banco: .asciiz "Total no banco: \n"

msg_maior_saldo: .asciiz "Maior saldo: \n"

msg_menor_saldo: .asciiz "Menor saldo: \n"

msg_dois_pontos: .asciiz ": "

.align 2 #alinhe o próximo dado em 2² bytes = 4 bytes
saldos: .space 400    # criando meu vetor de inteiros com capacidade maxima de 100 clientes 100 inteiros * 4 bytes

.text

main:
	
	la $s1 , saldos # Faço o carregamento do endereço de memoria do meu vetor
	
	la  $a0, msg_quantidade_de_clientes #carrego o endereço da minha string
	li  $v0, 4
	syscall # Nesse trecho faço o carregamento da minha string para imprimir
	
	# lê inteiro a quantidade de clientes
	li  $v0, 5
	syscall
	# salva o valor lido em S0
	move $s0, $v0
	
	li $t0, 0 # t0 vai ser o meu iniciador do loop para cadastrar os usuários como se fosse
		  # o meu int i = 0 em c
	
	loop:
		beq $t0 , $s0, fim # aqui temos uma condição para o loop se t0 for = a $s0, pulamos para o fim
		
		#--------------------
		la $a0, msg_saldo_inicial_do_cliente #carrego o endereço da minha string
		li $v0 , 4
		syscall # Nesse trecho faço o carregamento da minha string para imprimir
		#--------------------
		
		#----------------
		move $a0, $t0    
		li $v0, 1       # procedimento para imprimir nosso i
		syscall
		#----------------
		
		#----------------
		
		la $a0, msg_dois_pontos #imprimindo a string :, apenas por experiencia do usuario
		li $v0, 4
		syscall
		
		#----------------
		li  $v0, 5 #lendo o valor do saldo do cliente
		syscall
		#----------------
		
		#----------------
		
		add $t1, $t0, $zero 
		# carregando nosso i no registrador para usar para acessar nosso vetor
		mul $t1, $t1, 4
		#multiplicando nosso indice por 4, pois nosso vetor é composto por int de 4 byttes
		add $t1, $t1, $s1
		#somando com o endereço para acessar a posição no vetor
		
		#-----------------
		
		sw  $v0, 0($t1) # jogo o valor no vetor na posição i do nosso t0
		
		addi $t0, $t0, 1 #adiciono 1 no nosso i
		
		j loop # Aqui fazemos o programa voltar para o loop, quando ainda não terminou
		
		fim: # encerrando o loop
	
	
	
	painel:
	
	#----------	
	la $a0, msg_do_painel #imprimindo a mensagem do painel para o usuario interagir
	li $v0, 4
	syscall
	#-----------
	
	
	#----------------
		
	la $a0, msg_dois_pontos #imprimindo a string :, apenas por experiencia do usuario
	li $v0, 4
	syscall
		
	#----------------
	
	
	#---------
	
	li $v0, 5 #lendo a opção do usuario
	syscall
	
	move $t0, $v0 #movendo o para t0
		
	#---------
	
	beq $t0, 4, sair #se o usuario digitou 4, ele quer sair da aplicação
	
	beq $t0, 1, depositar
	
	beq $t0, 2, sacar
	
	beq $t0, 3, estatistica
	
	
	depositar:
	
	
		la $a0, msg_cliente #imprimindo a mensagem que pergunta qual cliente
		li $v0, 4
		syscall
		
		la $a0, msg_dois_pontos #imprimindo a string :, apenas por experiencia do usuario
		li $v0, 4
		syscall
		
		li $v0, 5 #lendo o cliente selecionado
		syscall
		move $t1, $v0 #movendo o para t1
		
		#validando cliente cliente: if (i < 0 || i >= n)
		slt  $t3, $t1, $zero   # t0 = 1 se i < 0
   		bne  $t3, $zero, cliente_invalido # se t3 Não for igual a 0 então é verdade, ou seja, cliente invalido

    		slt  $t3, $t1, $s0    # t0 = 1 se i < n
    		beq  $t3, $zero, cliente_invalido
		
		
		la $a0, msg_valor #imprimindo a mensagem que pergunta o valor a ser depositado
		li $v0, 4
		syscall
		
		la $a0, msg_dois_pontos #imprimindo a string :, apenas por experiencia do usuario
		li $v0, 4
		syscall
		
		li $v0, 5 #lendo o valor selecionado
		syscall 
		move $t2, $v0 #movendo o para t2
		
		mul $t1 , $t1 , 4 #multiplicando nosso indice por 4, pois nosso vetor é composto por int de 4 byttes
		add $t1 , $t1 , $s1 # somando o valor multiplicado com o endereço de memoria do vetor para acessar a posição
		lw $t4 , 0($t1) #carregamos o valor do cliente em t4
		add $t4, $t4, $t2 # fazemos o deposito
		sw $t4, 0($t1) # devolvemos o valor para o vetor
		
		la $a0, msg_deposito_realizado #imprimindo a string :, apenas por experiencia do usuario
		li $v0, 4
		syscall
		
		
		j painel
		
		cliente_invalido:
			la $a0, msg_cliente_nao_existe #imprimindo a mensagem de cliente invalido
			li $v0, 4
			syscall
			
			j painel
	
	
	sacar:
	
	
		la $a0, msg_cliente #imprimindo a mensagem que pergunta qual cliente
		li $v0, 4
		syscall
		
		la $a0, msg_dois_pontos #imprimindo a string : apenas por experiencia do usuario
		li $v0, 4
		syscall
		
		li $v0, 5 #lendo o cliente selecionado
		syscall
		move $t1, $v0 #movendo o para t1
		
		#validando cliente cliente: if (i < 0 || i >= n)
		slt  $t3, $t1, $zero   # t0 = 1 se i < 0
   		bne  $t3, $zero, cliente_invalido_saque # se t3 Não for igual a 0 então é verdade, ou seja, cliente invalido

    		slt  $t3, $t1, $s0    # t0 = 1 se i < n
    		beq  $t3, $zero, cliente_invalido_saque
		
		
		la $a0, msg_valor #imprimindo a mensagem que pergunta o valor a ser sacado
		li $v0, 4
		syscall
		
		la $a0, msg_dois_pontos #imprimindo a string :, apenas por experiencia do usuario
		li $v0, 4
		syscall
		
		li $v0, 5 #lendo o valor selecionado
		syscall 
		move $t2, $v0 #movendo o para t2
		
		mul $t1 , $t1 , 4 #multiplicando nosso indice por 4, pois nosso vetor é composto por int de 4 byttes
		add $t1 , $t1 , $s1 # somando o valor multiplicado com o endereço de memoria do vetor para acessar a posição
		lw $t4 , 0($t1) #carregamos o valor do cliente em t4
		
		slt  $t5, $t4, $t2   # t5 = t2 < t4 ou seja se o valor digitado for menor que o da conta
   		bne  $t5, $zero, saldo_insuficiente # se não for igual a 0, então é verdade e o valor é menor
		
		sub $t4, $t4, $t2 # fazemos o deposito
		sw $t4, 0($t1) # devolvemos o valor para o vetor
		
		la $a0, msg_saque_realizado #imprimindo a string :, apenas por experiencia do usuario
		li $v0, 4
		syscall
		
		
		j painel
		
		saldo_insuficiente: 
			la $a0, msg_saldo_insuficiente #imprimindo a mensagem de cliente invalido
			li $v0, 4
			syscall
			
			j painel
		
		cliente_invalido_saque:
			la $a0, msg_cliente_nao_existe #imprimindo a mensagem de cliente invalido
			li $v0, 4
			syscall
			
			j painel
		
			
	soma_saldos_rec:
    
    		addi $sp,$sp, -8 #Abrindo espaço na pilha para 2 itens
    		sw $ra, 4($sp)# Salvando endereço de retorno
    		sw $t1, 0($sp) #Salvando t1 (saldo atual) na pilha!!!
    
    		beq  $a1, $a2, soma_fim # Aqui vai ser nossa Base da recursão
    
    		mul $t0, $a1, 4 # Calculando endereço
    		add $t0, $t0, $a0 
    		lw $t1, 0($t0) # Carrega valor atual em $t1
    
    		# Precisamos atualizar a pilha com o valor lido de $t1 antes de chamar a recursão
    		sw $t1, 0($sp)            
    
    		addi $a1, $a1, 1 #Incrementa 1 no índice
    		jal soma_saldos_rec # Chama recursão
    
		# Ao voltar, t1 estaria com lixo, então recuperamos ele da pilha
    		lw   $t1, 0($sp) # entao vamos recuperar o valor original de t1
    		add  $v0, $v0, $t1 #Soma: Resultado da filha v0 + Atual t1
    
    	#Pula para o fim para não executar o return base que zera o v0
    	j soma_retorno

	soma_fim:
    		li $v0, 0 #o nosso caso base e retorna 0 na soma
	soma_retorno:
    		lw $ra, 4($sp # Recupera endereço de retorno
    		addi $sp, $sp, 8 # Fecha a pilha
    		jr $ra # Retorna


	maior_saldo_rec:
    		addi $sp, $sp, -8
    		sw $ra, 4($sp)
    
    		beq  $a1, $a2, maior_fim    # Se índice == tamanho, retorna
    
    		mul $t0, $a1, 4
    		add $t0, $t0, $a0
    		lw $t1, 0($t0) # Lemos o valor atual
    
    		slt $t2, $v0, $t1 #Se MaiorAtual v0 < Novo t1
    		beq $t2, $zero, maior_skip # Se não for menor, pula
    		move $v0, $t1 #Atualiza o maior
    
	maior_skip:
    		addi $a1, $a1, 1
    		jal  maior_saldo_rec # Chamamos a Recursão
    
	maior_fim:
    		lw $ra, 4($sp)
    		addi $sp, $sp, 8
    		jr $ra


	menor_saldo_rec:
    		addi $sp, $sp, -8
    		sw $ra, 4($sp)
    
    		beq $a1, $a2, menor_fim
    
    		mul $t0, $a1, 4
    		add $t0, $t0, $a0
    		lw $t1, 0($t0)
    
    		slt $t2, $t1, $v0          # Se Novo ($t1) < MenorAtual ($v0)
    		beq $t2, $zero, menor_skip
    		move $v0, $t1               # Atualiza o menor
    
	menor_skip:
    		addi $a1, $a1, 1
    		jal  menor_saldo_rec
    
	menor_fim:
    		lw $ra, 4($sp)
    		addi $sp, $sp, 8
    		jr   $ra

	
        estatistica:
    
    		# -------- Total no banco --------
    		la $a0, saldos          
    		li $a1, 0               
    		move $a2, $s0             
    		li $v0, 0               # Zera acumulador
    		jal soma_saldos_rec      
    		move $s2, $v0             
    
    		la $a0, msg_total_no_banco
    		li $v0, 4
    		syscall
    
    		move $a0, $s2             # Imprime o número
    		li $v0, 1
    		syscall
    
    		#Pular linha após o número
    		li  $a0, 10              # Código ASCII para \n
    		li $v0, 11              # Syscall para imprimir caractere
    		syscall
    
    		# -------- Maior saldo --------
    		la $a0, saldos          
    		li $a1, 0               
    		move $a2, $s0             
    		lw $v0, 0($a0)          # Inicializa maior com o primeiro elemento
    		jal maior_saldo_rec      
    		move $s3, $v0             
    
    		la $a0, msg_maior_saldo
    		li $v0, 4
    		syscall
    
    		move $a0, $s3# Imprime o número
    		li $v0, 1
    		syscall

    
    		li $a0, 10
    		li $v0, 11
    		syscall
    
    		# -------- Menor saldo --------
    		la $a0, saldos          
    		li $a1, 0               
    		move $a2, $s0             
    		lw $v0, 0($a0)          # Inicializa menor com o primeiro elemento
    		jal menor_saldo_rec      
    		move $s4, $v0             
    
    		la $a0, msg_menor_saldo
    		li $v0, 4
    		syscall
    
    		move $a0, $s4 # Imprime o número
    		li $v0, 1
    		syscall
    
    		
    		li $a0, 10
    		li $v0, 11
    		syscall
    
    	j painel

	sair:
	
	
	
	
		
					
