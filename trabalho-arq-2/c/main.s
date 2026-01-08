                                .globl  main
.data
msg_cliente:                    .asciiz "Cliente: \n"

msg_saldo_insuficiente:         .asciiz "Saldo insuficiente \n"

msg_saque_realizado:            .asciiz "Saque realizado \n"

msg_deposito_realizado:         .asciiz "Deposito realizado \n"

msg_cliente_nao_existe:         .asciiz "Cliente não existe \n "

msg_do_painel:                  .asciiz "\n1-Depositar  2-Sacar  3-Estatisticas  4-Sair\n"

msg_quantidade_de_clientes:     .asciiz "Quantidade de clientes: \n"

msg_saldo_inicial_do_cliente:   .asciiz "Saldo inicial do cliente \n"

msg_valor:                      .asciiz "Valor: \n"

msg_total_no_banco:             .asciiz "Total no banco: \n"

msg_maior_saldo:                .asciiz "Maior saldo: \n"

msg_menor_saldo:                .asciiz "Menor saldo: \n"

msg_dois_pontos:                .asciiz ": "

                                .align  2                                                   #alinhe o próximo dado em 2² bytes = 4 bytes
saldos:                         .space  400                                                 # criando meu vetor de inteiros com capacidade maxima de 100 clientes 100 inteiros * 4 bytes

.text

main:

    la      $s1,                saldos                                                      # Faço o carregamento do endereço de memoria do meu vetor

    la      $a0,                msg_quantidade_de_clientes                                  #carrego o endereço da minha string
    li      $v0,                4
    syscall                                                                                 # Nesse trecho faço o carregamento da minha string para imprimir

    # lê inteiro a quantidade de clientes
    li      $v0,                5
    syscall
    # salva o valor lido em S0
    move    $s0,                $v0

    li      $t0,                0                                                           # t0 vai ser o meu iniciador do loop para cadastrar os usuários como se fosse
    # o meu int i = 0 em c

loop:
    beq     $t0,                $s0,                            fim                         # aqui temos uma condição para o loop se t0 for = a $s0, pulamos para o fim

    #--------------------
    la      $a0,                msg_saldo_inicial_do_cliente                                #carrego o endereço da minha string
    li      $v0,                4
    syscall                                                                                 # Nesse trecho faço o carregamento da minha string para imprimir
    #--------------------

    #----------------
    move    $a0,                $t0
    li      $v0,                1                                                           # procedimento para imprimir nosso i
    syscall
    #----------------

    #----------------

    la      $a0,                msg_dois_pontos                                             #imprimindo a string :, apenas por experiencia do usuario
    li      $v0,                4
    syscall

    #----------------
    li      $v0,                5                                                           #lendo o valor do saldo do cliente
    syscall
    #----------------

    #----------------

    add     $t1,                $t0,                            $zero
    # carregando nosso i no registrador para usar para acessar nosso vetor
    mul     $t1,                $t1,                            4
    #multiplicando nosso indice por 4, pois nosso vetor é composto por int de 4 byttes
    add     $t1,                $t1,                            $s1
    #somando com o endereço para acessar a posição no vetor

    #-----------------

    sw      $v0,                0($t1)                                                      # jogo o valor no vetor na posição i do nosso t0

    addi    $t0,                $t0,                            1                           #adiciono 1 no nosso i

    j       loop                                                                            # Aqui fazemos o programa voltar para o loop, quando ainda não terminou

fim:                                                                                        # encerrando o loop



painel:

    #----------
    la      $a0,                msg_do_painel                                               #imprimindo a mensagem do painel para o usuario interagir
    li      $v0,                4
    syscall
    #-----------


    #----------------

    la      $a0,                msg_dois_pontos                                             #imprimindo a string :, apenas por experiencia do usuario
    li      $v0,                4
    syscall

    #----------------


    #---------

    li      $v0,                5                                                           #lendo a opção do usuario
    syscall

    move    $t0,                $v0                                                         #movendo o para t0

    #---------

    beq     $t0,                4,                              sair                        #se o usuario digitou 4, ele quer sair da aplicação

    beq     $t0,                1,                              depositar

    beq     $t0,                2,                              sacar

    beq     $t0,                3,                              estatistica


depositar:


    la      $a0,                msg_cliente                                                 #imprimindo a mensagem que pergunta qual cliente
    li      $v0,                4
    syscall

    la      $a0,                msg_dois_pontos                                             #imprimindo a string :, apenas por experiencia do usuario
    li      $v0,                4
    syscall

    li      $v0,                5                                                           #lendo o cliente selecionado
    syscall
    move    $t1,                $v0                                                         #movendo o para t1

    #validando cliente cliente: if (i < 0 || i >= n)
    slt     $t3,                $t1,                            $zero                       # t0 = 1 se i < 0
    bne     $t3,                $zero,                          cliente_invalido            # se t3 Não for igual a 0 então é verdade, ou seja, cliente invalido

    slt     $t3,                $t1,                            $s0                         # t0 = 1 se i < n
    beq     $t3,                $zero,                          cliente_invalido


    la      $a0,                msg_valor                                                   #imprimindo a mensagem que pergunta o valor a ser depositado
    li      $v0,                4
    syscall

    la      $a0,                msg_dois_pontos                                             #imprimindo a string :, apenas por experiencia do usuario
    li      $v0,                4
    syscall

    li      $v0,                5                                                           #lendo o valor selecionado
    syscall
    move    $t2,                $v0                                                         #movendo o para t2

    mul     $t1,                $t1,                            4                           #multiplicando nosso indice por 4, pois nosso vetor é composto por int de 4 byttes
    add     $t1,                $t1,                            $s1                         # somando o valor multiplicado com o endereço de memoria do vetor para acessar a posição
    lw      $t4,                0($t1)                                                      #carregamos o valor do cliente em t4
    add     $t4,                $t4,                            $t2                         # fazemos o deposito
    sw      $t4,                0($t1)                                                      # devolvemos o valor para o vetor

    la      $a0,                msg_deposito_realizado                                      #imprimindo a string :, apenas por experiencia do usuario
    li      $v0,                4
    syscall


    j       painel

cliente_invalido:
    la      $a0,                msg_cliente_nao_existe                                      #imprimindo a mensagem de cliente invalido
    li      $v0,                4
    syscall

    j       painel


sacar:


    la      $a0,                msg_cliente                                                 #imprimindo a mensagem que pergunta qual cliente
    li      $v0,                4
    syscall

    la      $a0,                msg_dois_pontos                                             #imprimindo a string : apenas por experiencia do usuario
    li      $v0,                4
    syscall

    li      $v0,                5                                                           #lendo o cliente selecionado
    syscall
    move    $t1,                $v0                                                         #movendo o para t1

    #validando cliente cliente: if (i < 0 || i >= n)
    slt     $t3,                $t1,                            $zero                       # t0 = 1 se i < 0
    bne     $t3,                $zero,                          cliente_invalido_saque      # se t3 Não for igual a 0 então é verdade, ou seja, cliente invalido

    slt     $t3,                $t1,                            $s0                         # t0 = 1 se i < n
    beq     $t3,                $zero,                          cliente_invalido_saque


    la      $a0,                msg_valor                                                   #imprimindo a mensagem que pergunta o valor a ser sacado
    li      $v0,                4
    syscall

    la      $a0,                msg_dois_pontos                                             #imprimindo a string :, apenas por experiencia do usuario
    li      $v0,                4
    syscall

    li      $v0,                5                                                           #lendo o valor selecionado
    syscall
    move    $t2,                $v0                                                         #movendo o para t2

    mul     $t1,                $t1,                            4                           #multiplicando nosso indice por 4, pois nosso vetor é composto por int de 4 byttes
    add     $t1,                $t1,                            $s1                         # somando o valor multiplicado com o endereço de memoria do vetor para acessar a posição
    lw      $t4,                0($t1)                                                      #carregamos o valor do cliente em t4

    slt     $t5,                $t4,                            $t2                         # t5 = t2 < t4 ou seja se o valor digitado for menor que o da conta
    bne     $t5,                $zero,                          saldo_insuficiente          # se não for igual a 0, então é verdade e o valor é menor

    sub     $t4,                $t4,                            $t2                         # fazemos o deposito
    sw      $t4,                0($t1)                                                      # devolvemos o valor para o vetor

    la      $a0,                msg_saque_realizado                                         #imprimindo a string :, apenas por experiencia do usuario
    li      $v0,                4
    syscall


    j       painel

saldo_insuficiente:
    la      $a0,                msg_saldo_insuficiente                                      #imprimindo a mensagem de cliente invalido
    li      $v0,                4
    syscall

    j       painel

cliente_invalido_saque:
    la      $a0,                msg_cliente_nao_existe                                      #imprimindo a mensagem de cliente invalido
    li      $v0,                4
    syscall

    j       painel



soma_saldos_rec:                                                                            #soma de saldo recursivo

    addi    $sp,                $sp,                            -8                          #abrimos espaço na pilha para salvar dados importantes da função

    sw      $ra,                4($sp)                                                      #salvamos o endereço de retorno para não perder quando chamarmos a função novamente (recursão)

    beq     $a1,                $a2,                            soma_fim                    # condição de parada da recursão: se o índice atual ($a1) for igual ao número de clientes ($a2), encerramos
    mul     $t0,                $a1,                            4                           #calculamos o deslocamento do vetor: i * 4 (cada inteiro ocupa 4 bytes)

    add     $t0,                $t0,                            $a0                         #somamos o deslocamento ao endereço base do vetor para acessar a posição correta
    lw      $t1,                0($t0)                                                      #caregamos o saldo do cliente atual para o registrador t1

    addi    $a1,                $a1,                            1                           # incrementamos o índice para a próxima chamada recursiva
    jal     soma_saldos_rec                                                                 # chamada recursiva da função para continuar somando os próximos saldo
    add     $v0,                $v0,                            $t1                         #somamos o saldo atual ao valor retornado pelas chamadas recursivas

soma_fim:

    lw      $ra,                4($sp)                                                      # restauramos o endereço de retorno da função
    addi    $sp,                $sp,                            8                           # liberamos o espaço utilizado na pilha
    jr      $ra                                                                             # retornamos para quem chamou a função


maior_saldo_rec:                                                                            #maior saldo recursivo

    addi    $sp,                $sp,                            -12                         #reservamos espaço na pilha para salvar ra e o índice atual

    sw      $ra,                8($sp)                                                      # salvamos o endereço de retorno da função
    sw      $a1,                4($sp)                                                      #salvamos o índice atual para restaurar depois da recursão

    beq     $a1,                $a2,                            maior_fim                   #condição de parada: se já percorremos todos os clientes, encerramos

    mul     $t0,                $a1,                            4                           # calculamos a posição do cliente no vetor

    add     $t0,                $t0,                            $a0                         # somamos com o endereço base do vetor
    lw      $t1,                0($t0)                                                      #carregamos o saldo atual para t1
    addi    $a1,                $a1,                            1                           # avançamos para o próximo cliente

    jal     maior_saldo_rec                                                                 #chamada recursiva para processar o restante do vetor

    bgt     $t1,                $v0,                            atualiza_maior              #se o saldo atual for maior que o maior encontrado até agora, atualizamos

    j       maior_retorno                                                                   #caso contrário, mantemos o maior valor atual

atualiza_maior:

    move    $v0,                $t1                                                         #atualizamos o maior saldo encontrado

maior_retorno:

    lw      $a1,                4($sp)                                                      #restauramos o índice anterior
    lw      $ra,                8($sp)                                                      #restauramos o endereço de retorno
    addi    $sp,                $sp,                            12                          #liberamos o espaço da pilha

    jr      $ra                                                                             #retornamos da função

maior_fim:

    lw      $ra,                8($sp)                                                      # restauramos o endereço de retorno
    addi    $sp,                $sp,                            12                          #liberamos o espaço da pilha

    li      $v0,                0                                                           #inicializamos o maior saldo como zero
    jr      $ra                                                                             #retornamos


menor_saldo_rec:

    addi    $sp,                $sp,                            -12                         # reservamos espaço na pilha para ra e índice

    sw      $ra,                8($sp)                                                      #salvamos o endereço de retorno

    sw      $a1,                4($sp)                                                      #salvamos o índice atual
    beq     $a1,                $a2,                            menor_fim                   #condição de parada: percorremos todos os clientes

    mul     $t0,                $a1,                            4                           #calculamos a posição do cliente no vetor
    add     $t0,                $t0,                            $a0                         #somamos ao endereço base
    lw      $t1,                0($t0)                                                      # carregamos o saldo atual
    addi    $a1,                $a1,                            1                           # avançamos para o próximo cliente

    jal     menor_saldo_rec                                                                 #chamada recursiva para o restante do vetor
    blt     $t1,                $v0,                            atualiza_menor              #se o saldo atual for menor que o menor encontrado, atualizamos

    j       menor_retorno                                                                   #caso contrário, mantemos o valor atual

atualiza_menor:

    move    $v0,                $t1                                                         #atualizamos o menor saldo encontrado

menor_retorno:

    lw      $a1,                4($sp)                                                      #restauramos o índice

    lw      $ra,                8($sp)                                                      #restauramos o endereço de retorno
    addi    $sp,                $sp,                            12                          #liberamos a pilha
    jr      $ra                                                                             # retornamos

menor_fim:

    lw      $ra,                8($sp)                                                      # restauramos o endereço de retorno
    addi    $sp,                $sp,                            12                          # liberamos a pilha
    li      $v0,                9999999999                                                  # inicializamos o menor saldo com o maior inteiro possível

    jr      $ra                                                                             #retornamos


estatistica:


    la      $a0,                saldos                                                      # carrego o endereço base do vetor de saldos no registrador a0 para enviar para a função
    li      $a1,                0                                                           #inicializo o índice em 0 para começar a percorrer o vetor
    move    $a2,                $s0                                                         #movo a quantidade de clientes para a2, que será o limite da função recursiva
    jal     soma_saldos_rec                                                                 # chamo a função recursiva que calcula a soma total dos saldos

    la      $a0,                msg_total_no_banco                                          #carrego o endereço da mensagem Total no banco para imprimir
    li      $v0,                4
    syscall                                                                                 #nesse trecho faço o carregamento da minha string para imprimir

    move    $a0,                $v0                                                         #movo o valor retornado pela função (total do banco) para a0 para poder imprimir
    li      $v0,                1                                                           # código da syscall para imprimir inteiro
    syscall                                                                                 #nesse trecho faço a impressão do valor inteiro total do banco


    la      $a0,                saldos                                                      #carrego novamente o endereço base do vetor de saldos
    li      $a1,                0                                                           # reinicializo o índice para começar do primeiro cliente
    move    $a2,                $s0                                                         #movo novamente a quantidade de clientes para a2
    jal     maior_saldo_rec                                                                 # chamo a função recursiva que calcula o maior saldo

    la      $a0,                msg_maior_saldo                                             #carrego o endereço da mensagem "Maior saldo" para imprimir
    li      $v0,                4
    syscall                                                                                 #nesse trecho faço o carregamento da minha string para imprimir

    move    $a0,                $v0                                                         #movo o maior saldo retornado pela função para a0
    li      $v0,                1                                                           #código da syscall para imprimir inteiro
    syscall                                                                                 # nesse trecho faço a impressão do maior saldo


    la      $a0,                saldos                                                      # carrego novamente o endereço base do vetor de saldos
    li      $a1,                0                                                           #inicializo o índice em 0 para percorrer o vetor desde o início
    move    $a2,                $s0                                                         # movo a quantidade de clientes para a2
    jal     menor_saldo_rec                                                                 #chamo a função recursiva que calcula o menor saldo

    la      $a0,                msg_menor_saldo                                             #carrego o endereço da mensagem "Menor saldo" para imprimir
    li      $v0,                4
    syscall                                                                                 #nesse trecho faço o carregamento da minha string para imprimir

    move    $a0,                $v0                                                         #movo o menor saldo retornado pela função para a0
    li      $v0,                1                                                           # código da syscall para imprimir inteiro
    syscall                                                                                 # nesse trecho faço a impressão do menor saldo

    j       painel                                                                          # aqui fazemos o programa retornar para o painel principal


sair:






