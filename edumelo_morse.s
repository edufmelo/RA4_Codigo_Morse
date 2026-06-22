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

    @ --- SECAO DE DADOS GERADA PELO COMPILADOR ---
    .align 2
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
    @ =========================================================
    @ RUNTIME ENVIRONMENT: EXIBICAO MORSE NO HARDWARE
    @ =========================================================
    LDR R4, =numResultados
    LDR R4, [R4]             @ tamanho = len(resultados)
    LDR R5, =resultados      @ ponteiro_array = &resultados[0]
    MOV R6, #0               @ i = 0
    LDR R11, =0xFF200000     @ ponteiro_hardware_leds

loop_letras:
    CMP R6, R4
    BGE fim_morse            @ if (i >= tamanho) break

    VLDR D0, [R5]            
    VCVT.S32.F64 S0, D0      @ Cast de double para int (truncamento)
    VMOV R7, S0              @ R7 guarda o caractere ASCII gerado pela expressao RPN

    CMP R7, #32              @ ASCII ' ' = 32 (Espaco entre palavras)
    BEQ espaco_palavra

    SUB R7, R7, #48          @ Indice = ASCII - 48 (Pois a tabela inicia no '0')
    LSL R7, R7, #2           @ offset = indice * 4 bytes
    LDR R8, =morse_dict
    LDR R9, [R8, R7]         @ Carrega a mascara hexa otimizada

loop_simbolos:
    CMP R9, #0               
    BEQ proxima_letra        @ Failsafe: se a mascara estiver vazia

    @ Consome o Nibble mais significativo para identificar o simbolo
    LSR R10, R9, #28         
    LSL R9, R9, #4           @ Desloca os proximos simbolos para a frente

    CMP R10, #1
    BLEQ pisca_ponto
    CMP R10, #2
    BLEQ pisca_traco

    @ --- CORRECAO DE TIMING DO COMPILADOR ---
    @ Verifica se esse foi o ultimo simbolo da mascara
    CMP R9, #0               
    BEQ proxima_letra        @ Pula o delay intra-letra se a letra acabou

    @ Delay DENTRO da letra (450ms) - Executa apenas se houver proximos simbolos
    LDR R0, =4500000         
    BL delay
    B loop_simbolos

proxima_letra:
    @ Delay ENTRE letras (900ms) - Executa sempre ao fim de um caractere
    LDR R0, =9000000         
    BL delay
    B avanca_array

espaco_palavra:
    @ Delay ENTRE palavras (Meta = 2000ms)
    @ Como a rotina 'proxima_letra' anterior ja gerou um atraso de 900ms,
    @ descontamos esse valor para manter o tempo absoluto: 2000 - 900 = 1100ms.
    LDR R0, =11000000        
    BL delay

avanca_array:
    ADD R5, R5, #8           @ Avanca ponteiro de memoria (8 bytes por double)
    ADD R6, R6, #1           @ i++
    B loop_letras

    @ =========================================================
    @ SUBROTINAS DE I/O (DRIVERS FISICOS)
    @ =========================================================
pisca_ponto:
    MOV R1, #0x3FF           
    STR R1, [R11]
    LDR R0, =3000000         
    B apaga_led

pisca_traco:
    MOV R1, #0x3FF           
    STR R1, [R11]
    LDR R0, =6000000         

apaga_led:
    PUSH {LR}                
    BL delay
    MOV R1, #0               
    STR R1, [R11]
    POP {PC}                 

delay:
    SUBS R0, R0, #1
    BNE delay
    BX LR

fim_morse:

fim:
    B fim
