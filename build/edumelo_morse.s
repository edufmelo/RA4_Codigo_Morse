.global _start

.data
    .align 3
    const_19_0: .double 19.0
    .align 3
    const_50_0: .double 50.0
    .align 3
    const_18_0: .double 18.0
    .align 3
    const_86_0: .double 86.0
    .align 3
    const_1_0: .double 1.0
    .align 3
    const_32_0: .double 32.0
    .align 3
    const_0_0: .double 0.0
    .align 3
    const_27_0: .double 27.0
    .align 3
    const_26_0: .double 26.0
    .align 3
    const_29_0: .double 29.0
    .align 3
    resultados: .space 800       @ espaco para 100 doubles
    numResultados: .word 0

    @ SECAO DE DADOS (DICIONARIO MORSE)
    .align 2   @ alinha a tabela em múltiplos de 4 bytes
    morse_dict:
    .word 0x22222000  @ Indice 0 -> Letra 0
    .word 0x12222000  @ Indice 1 -> Letra 1
    .word 0x11222000  @ Indice 2 -> Letra 2
    .word 0x11122000  @ Indice 3 -> Letra 3
    .word 0x11112000  @ Indice 4 -> Letra 4
    .word 0x11111000  @ Indice 5 -> Letra 5
    .word 0x21111000  @ Indice 6 -> Letra 6
    .word 0x22111000  @ Indice 7 -> Letra 7
    .word 0x22211000  @ Indice 8 -> Letra 8
    .word 0x22221000  @ Indice 9 -> Letra 9
    .word 0x00000000  @ Indice 10 -> Nulo
    .word 0x00000000  @ Indice 11 -> Nulo
    .word 0x00000000  @ Indice 12 -> Nulo
    .word 0x00000000  @ Indice 13 -> Nulo
    .word 0x00000000  @ Indice 14 -> Nulo
    .word 0x00000000  @ Indice 15 -> Nulo
    .word 0x00000000  @ Indice 16 -> Nulo
    .word 0x12000000  @ Indice 17 -> Letra A
    .word 0x21110000  @ Indice 18 -> Letra B
    .word 0x21210000  @ Indice 19 -> Letra C
    .word 0x21100000  @ Indice 20 -> Letra D
    .word 0x10000000  @ Indice 21 -> Letra E
    .word 0x11210000  @ Indice 22 -> Letra F
    .word 0x22100000  @ Indice 23 -> Letra G
    .word 0x11110000  @ Indice 24 -> Letra H
    .word 0x11000000  @ Indice 25 -> Letra I
    .word 0x12220000  @ Indice 26 -> Letra J
    .word 0x21200000  @ Indice 27 -> Letra K
    .word 0x12110000  @ Indice 28 -> Letra L
    .word 0x22000000  @ Indice 29 -> Letra M
    .word 0x21000000  @ Indice 30 -> Letra N
    .word 0x22200000  @ Indice 31 -> Letra O
    .word 0x12210000  @ Indice 32 -> Letra P
    .word 0x22120000  @ Indice 33 -> Letra Q
    .word 0x12100000  @ Indice 34 -> Letra R
    .word 0x11100000  @ Indice 35 -> Letra S
    .word 0x20000000  @ Indice 36 -> Letra T
    .word 0x11200000  @ Indice 37 -> Letra U
    .word 0x11120000  @ Indice 38 -> Letra V
    .word 0x12200000  @ Indice 39 -> Letra W
    .word 0x21120000  @ Indice 40 -> Letra X
    .word 0x21220000  @ Indice 41 -> Letra Y
    .word 0x22110000  @ Indice 42 -> Letra Z

.text
_start:

    @ (START) - inicio do programa

    @ Comando RPN: ( 19.0 50.0 + )
    LDR R4, =const_19_0
    VLDR D0, [R4]             @ carrega double 19.0
    LDR R4, =const_50_0
    VLDR D1, [R4]             @ carrega double 50.0
    VADD.F64 D2, D0, D1    @ soma real
    @ Armazena resultado no historico
    LDR R0, =numResultados
    LDR R1, [R0]                @ R1 = numResultados atual
    LDR R2, =resultados
    LSL R3, R1, #3              @ offset = R1 * 8
    ADD R2, R2, R3
    VSTR D2, [R2]     @ guarda resultado
    ADD R1, R1, #1
    STR R1, [R0]                @ numResultados++

    @ Comando RPN: ( 50.0 18.0 + )
    LDR R4, =const_50_0
    VLDR D0, [R4]             @ carrega double 50.0
    LDR R4, =const_18_0
    VLDR D1, [R4]             @ carrega double 18.0
    VADD.F64 D2, D0, D1    @ soma real
    @ Armazena resultado no historico
    LDR R0, =numResultados
    LDR R1, [R0]                @ R1 = numResultados atual
    LDR R2, =resultados
    LSL R3, R1, #3              @ offset = R1 * 8
    ADD R2, R2, R3
    VSTR D2, [R2]     @ guarda resultado
    ADD R1, R1, #1
    STR R1, [R0]                @ numResultados++

    @ Comando RPN: ( 86.0 1.0 - )
    LDR R4, =const_86_0
    VLDR D0, [R4]             @ carrega double 86.0
    LDR R4, =const_1_0
    VLDR D1, [R4]             @ carrega double 1.0
    VSUB.F64 D2, D0, D1    @ subtracao real
    @ Armazena resultado no historico
    LDR R0, =numResultados
    LDR R1, [R0]                @ R1 = numResultados atual
    LDR R2, =resultados
    LSL R3, R1, #3              @ offset = R1 * 8
    ADD R2, R2, R3
    VSTR D2, [R2]     @ guarda resultado
    ADD R1, R1, #1
    STR R1, [R0]                @ numResultados++

    @ Comando RPN: ( 32.0 0.0 + )
    LDR R4, =const_32_0
    VLDR D0, [R4]             @ carrega double 32.0
    LDR R4, =const_0_0
    VLDR D1, [R4]             @ carrega double 0.0
    VADD.F64 D2, D0, D1    @ soma real
    @ Armazena resultado no historico
    LDR R0, =numResultados
    LDR R1, [R0]                @ R1 = numResultados atual
    LDR R2, =resultados
    LSL R3, R1, #3              @ offset = R1 * 8
    ADD R2, R2, R3
    VSTR D2, [R2]     @ guarda resultado
    ADD R1, R1, #1
    STR R1, [R0]                @ numResultados++

    @ Comando RPN: ( 50.0 27.0 + )
    LDR R4, =const_50_0
    VLDR D0, [R4]             @ carrega double 50.0
    LDR R4, =const_27_0
    VLDR D1, [R4]             @ carrega double 27.0
    VADD.F64 D2, D0, D1    @ soma real
    @ Armazena resultado no historico
    LDR R0, =numResultados
    LDR R1, [R0]                @ R1 = numResultados atual
    LDR R2, =resultados
    LSL R3, R1, #3              @ offset = R1 * 8
    ADD R2, R2, R3
    VSTR D2, [R2]     @ guarda resultado
    ADD R1, R1, #1
    STR R1, [R0]                @ numResultados++

    @ Comando RPN: ( 50.0 19.0 + )
    LDR R4, =const_50_0
    VLDR D0, [R4]             @ carrega double 50.0
    LDR R4, =const_19_0
    VLDR D1, [R4]             @ carrega double 19.0
    VADD.F64 D2, D0, D1    @ soma real
    @ Armazena resultado no historico
    LDR R0, =numResultados
    LDR R1, [R0]                @ R1 = numResultados atual
    LDR R2, =resultados
    LSL R3, R1, #3              @ offset = R1 * 8
    ADD R2, R2, R3
    VSTR D2, [R2]     @ guarda resultado
    ADD R1, R1, #1
    STR R1, [R0]                @ numResultados++

    @ Comando RPN: ( 50.0 26.0 + )
    LDR R4, =const_50_0
    VLDR D0, [R4]             @ carrega double 50.0
    LDR R4, =const_26_0
    VLDR D1, [R4]             @ carrega double 26.0
    VADD.F64 D2, D0, D1    @ soma real
    @ Armazena resultado no historico
    LDR R0, =numResultados
    LDR R1, [R0]                @ R1 = numResultados atual
    LDR R2, =resultados
    LSL R3, R1, #3              @ offset = R1 * 8
    ADD R2, R2, R3
    VSTR D2, [R2]     @ guarda resultado
    ADD R1, R1, #1
    STR R1, [R0]                @ numResultados++

    @ Comando RPN: ( 50.0 29.0 + )
    LDR R4, =const_50_0
    VLDR D0, [R4]             @ carrega double 50.0
    LDR R4, =const_29_0
    VLDR D1, [R4]             @ carrega double 29.0
    VADD.F64 D2, D0, D1    @ soma real
    @ Armazena resultado no historico
    LDR R0, =numResultados
    LDR R1, [R0]                @ R1 = numResultados atual
    LDR R2, =resultados
    LSL R3, R1, #3              @ offset = R1 * 8
    ADD R2, R2, R3
    VSTR D2, [R2]     @ guarda resultado
    ADD R1, R1, #1
    STR R1, [R0]                @ numResultados++

    @ (END) - fim do programa

    @ Fim do programa
    @ DELAY_SCALE = ciclos por ms (ajustado para calibrar no CPUlator)
    @ tempo real = 10000
    .equ DELAY_SCALE, 15000    @ valor teste
    @ ---
    @ Rotina responsavel por exibir o resultado em codigo morse
    @ utilizando os LEDs
    LDR R4, =numResultados
    LDR R4, [R4]             @ quantidade de resultados armazenados
    LDR R5, =resultados      @ vetor de resultados
    MOV R6, #0               @ indice atual
    LDR R11, =0xFF200000     @ endereco dos LEDs

loop_letras:
    CMP R6, R4
    BGE fim_morse            @ if (i >= tamanho) break

    VLDR D0, [R5]            
    VCVT.S32.F64 S0, D0      @ converte o valor armazenado para inteiro ASCII
    VMOV R7, S0              @ R7 guarda o caractere ASCII

    CMP R7, #32              @ ASCII ' ' = 32 (espaco entre palavras)
    BEQ espaco_palavra

    SUB R7, R7, #48          @ indice = ASCII - 48
    LSL R7, R7, #2           @ offset = indice * 4 bytes
    LDR R8, =morse_dict
    LDR R9, [R8, R7]         @ busca o padrao morse correspondente ao caractere

loop_simbolos:
    CMP R9, #0               @ ja consumimos todos os simbolos desta letra?
    BEQ proxima_letra        @ se sim, NAO aplica o delay intra-letra (evita atraso extra)

    LSR R10, R9, #28         @ pega os 4 bits mais significativos = proximo símbolo
    LSL R9, R9, #4           @ descarta esse simbolo, empurra o proximo pra frente

    CMP R10, #1
    BLEQ pisca_ponto
    CMP R10, #2
    BLEQ pisca_traco

    CMP R9, #0               
    BEQ proxima_letra        @ evita adicionar atraso apos o ultimo simbolo da letra

    LDR R0, =(450 * DELAY_SCALE)          @ delay DENTRO da letra (450ms)
    BL delay
    B loop_simbolos

proxima_letra:
    LDR R0, =(900 * DELAY_SCALE)         @ delay ENTRE letras (900ms)
    BL delay
    B avanca_array

espaco_palavra:
    LDR R0, =(1100 * DELAY_SCALE)       @ espaco entre palavras (ajustado para totalizar 2000 ms)
    BL delay

avanca_array:
    ADD R5, R5, #8           @ avanca ponteiro de memoria
    ADD R6, R6, #1           @ i++
    B loop_letras

    @ ---
    @ Rotinas de controle dos LEDs e temporizacao
    @ ---
pisca_ponto:
    MOV R1, #0x3FF           @ todos os leds = 1111111111
    STR R1, [R11]
    LDR R0, =(300 * DELAY_SCALE)         
    B apaga_led

pisca_traco:
    MOV R1, #0x3FF           
    STR R1, [R11]
    LDR R0, =(600 * DELAY_SCALE)         
    @ cai direto em apaga_led (sem branch) — mesmo efeito de B apaga_led

apaga_led:
    PUSH {LR}                
    BL delay
    MOV R1, #0               
    STR R1, [R11]
    POP {PC}                 

delay:
    SUBS R0, R0, #1         @ R0-=1
    BNE delay
    BX LR                   @ volta para quem chamou

fim_morse:

fim:
    B fim
