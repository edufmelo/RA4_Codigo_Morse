import sys
import os

from semantico import (
    prepararEntradaSemantica, 
    decorarArvoreComLinhas, 
    construirTabelaSimbolos, 
    verificarTipos, 
    gerarArvoreAtribuida,
    gerarAssembly
)

# Dicionário morse utilizado na geração do assembly
# Cada letra é convertida para uma representação hexadecimal

MORSE_DIC = {
    "A": ".-",   "B": "-...", "C": "-.-.", "D": "-..",  "E": ".",
    "F": "..-.", "G": "--.",  "H": "....", "I": "..",   "J": ".---",
    "K": "-.-",  "L": ".-..", "M": "--",   "N": "-.",   "O": "---",
    "P": ".--.", "Q": "--.-", "R": ".-.",  "S": "...",  "T": "-",
    "U": "..-",  "V": "...-", "W": ".--",  "X": "-..-", "Y": "-.--",
    "Z": "--..",
    "0": "-----", "1": ".----", "2": "..---", "3": "...--", "4": "....-",
    "5": ".....", "6": "-....", "7": "--...", "8": "---..", "9": "----."
}

def padraoParaHexadecimal(padrao):
    """
    Converte um padrão morse para uma máscara hexadecimal.

    Cada símbolo ocupa 4 bits dentro de um .word: 1=ponto, 2=traço,
    0=fim dos símbolos. Assim a letra inteira é lida em assembly só com
    LSR/LSL, sem percorrer string ou guardar o tamanho de cada código.
    """

    hex_str = ""
    for char in padrao:
        if char == '.': hex_str += "1"
        elif char == '-': hex_str += "2"
    
    # Completa string com 0 a direita até ela ter 8 caracteres
    hex_str = hex_str.ljust(8, '0')
    return f"0x{hex_str}"

def gerarDicionarioMorse():
    """
    Gera a tabela morse que será adicionada na seção de dados
    """

    linhas_asm = [
        "    @ SECAO DE DADOS (DICIONARIO MORSE)",
        "    .align 2   @ alinha a tabela em múltiplos de 4 bytes",
        "    morse_dict:"
    ]

    # Range do ASCII de 0 a Z
    for ascii_code in range(48, 91):
        # Transforma de volta para caractere
        char = chr(ascii_code)
        # Caso exista no dic criado, converte para hex
        if char in MORSE_DIC:
            hex_val = padraoParaHexadecimal(MORSE_DIC[char])
            linhas_asm.append(f"    .word {hex_val}  @ Indice {ascii_code-48} -> Letra {char}")
        # Caso não, preenche com 0x00000000 (não deixar array com buraco)
        else:
            linhas_asm.append(f"    .word 0x00000000  @ Indice {ascii_code-48} -> Nulo")
    return linhas_asm

def gerarAssemblyMorse(arvore_atribuida, nome_arquivo):
    """
    Adiciona a lógica de código morse ao assembly gerado
    """

    codigo_base = gerarAssembly(arvore_atribuida, nome_arquivo)
    # Armazena símbolos morse em hexa
    dicionario_dinamico = gerarDicionarioMorse()
    
    # Verifica se a quantidade de resultados ultrapassa o espaço reservado
    qtd_resultados = sum(1 for linha in codigo_base if "numResultados++" in linha)
    if qtd_resultados > 100:
        print(f"\nO programa exige {qtd_resultados} espaços de memória")
        print("A secao .space aloca apenas 800 bytes (100 doubles)")

    rotina_morse = [
        "    @ DELAY_SCALE = ciclos por ms (ajustado para calibrar no CPUlator)",
        "    @ tempo real = 10000",
        "    .equ DELAY_SCALE, 15000    @ valor teste",
        "    @ ---",
        "    @ Rotina responsavel por exibir o resultado em codigo morse",
        "    @ utilizando os LEDs",
        "    LDR R4, =numResultados",  
        "    LDR R4, [R4]             @ quantidade de resultados armazenados",
        "    LDR R5, =resultados      @ vetor de resultados",
        "    MOV R6, #0               @ indice atual",
        "    LDR R11, =0xFF200000     @ endereco dos LEDs",
        "",
        "loop_letras:",
        "    CMP R6, R4",
        "    BGE fim_morse            @ if (i >= tamanho) break",
        "",
        "    VLDR D0, [R5]            ",
        "    VCVT.S32.F64 S0, D0      @ converte o valor armazenado para inteiro ASCII",
        "    VMOV R7, S0              @ R7 guarda o caractere ASCII",
        "",
        "    CMP R7, #32              @ ASCII ' ' = 32 (espaco entre palavras)",
        "    BEQ espaco_palavra",
        "",
        "    SUB R7, R7, #48          @ indice = ASCII - 48",
        "    LSL R7, R7, #2           @ offset = indice * 4 bytes",
        "    LDR R8, =morse_dict",
        "    LDR R9, [R8, R7]         @ busca o padrao morse correspondente ao caractere",
        "",
        "loop_simbolos:",
        "    CMP R9, #0               @ ja consumimos todos os simbolos desta letra?",
        "    BEQ proxima_letra        @ se sim, NAO aplica o delay intra-letra (evita atraso extra)",
        "",
        "    LSR R10, R9, #28         @ pega os 4 bits mais significativos = proximo símbolo",
        "    LSL R9, R9, #4           @ descarta esse simbolo, empurra o proximo pra frente",
        "",
        "    CMP R10, #1",
        "    BLEQ pisca_ponto",
        "    CMP R10, #2",
        "    BLEQ pisca_traco",
        "",
        "    CMP R9, #0               ",
        "    BEQ proxima_letra        @ evita adicionar atraso apos o ultimo simbolo da letra",
        "",
        "    LDR R0, =(450 * DELAY_SCALE)          @ delay DENTRO da letra (450ms)",
        "    BL delay",
        "    B loop_simbolos",
        "",
        "proxima_letra:",
        "    LDR R0, =(900 * DELAY_SCALE)         @ delay ENTRE letras (900ms)",
        "    BL delay",
        "    B avanca_array",
        "",
        "espaco_palavra:",
        "    LDR R0, =(1100 * DELAY_SCALE)       @ espaco entre palavras (ajustado para totalizar 2000 ms)",
        "    BL delay",
        "",
        "avanca_array:",
        "    ADD R5, R5, #8           @ avanca ponteiro de memoria",
        "    ADD R6, R6, #1           @ i++",
        "    B loop_letras",
        "",
        "    @ ---",
        "    @ Rotinas de controle dos LEDs e temporizacao",
        "    @ ---",
        "pisca_ponto:",
        "    MOV R1, #0x3FF           @ todos os leds = 1111111111",
        "    STR R1, [R11]",
        "    LDR R0, =(300 * DELAY_SCALE)         ",
        "    B apaga_led",
        "",
        "pisca_traco:",
        "    MOV R1, #0x3FF           ",
        "    STR R1, [R11]",
        "    LDR R0, =(600 * DELAY_SCALE)         ",
        "    @ cai direto em apaga_led (sem branch) — mesmo efeito de B apaga_led",
        "",
        "apaga_led:",
        "    PUSH {LR}                ",
        "    BL delay",
        "    MOV R1, #0               ",
        "    STR R1, [R11]",
        "    POP {PC}                 ",
        "",
        "delay:",
        "    SUBS R0, R0, #1         @ R0-=1",
        "    BNE delay",
        "    BX LR                   @ volta para quem chamou",
        "",
        "fim_morse:"
    ]

    codigo_final = []
    
    for linha in codigo_base:
        linha_limpa = linha.strip()
        
        if linha_limpa == ".text":
            codigo_final.extend(dicionario_dinamico)
            codigo_final.append("")
            codigo_final.append(linha)
        elif linha_limpa.startswith("fim:"):
            codigo_final.extend(rotina_morse)
            codigo_final.append("")
            codigo_final.append(linha)
        else:
            codigo_final.append(linha)

    try:
        os.makedirs(os.path.dirname(nome_arquivo), exist_ok=True)
        with open(nome_arquivo, 'w', encoding='utf-8') as f:
            for linha in codigo_final:
                f.write(linha + "\n")
    except Exception as e:
        print(f"Erro ao salvar o arquivo Assembly: {e}")

def compilarParaMorse(nome_arquivo):
    """
    Executa o pipeline completo do compilador e converte a saída final.
    """
    tokens, arvore_inicial = prepararEntradaSemantica(nome_arquivo)
    if not arvore_inicial: return

    decorarArvoreComLinhas(arvore_inicial, tokens)
    tabela, erros_decl = construirTabelaSimbolos(arvore_inicial)
    erros_tipo = verificarTipos(arvore_inicial, tabela)

    if erros_decl or erros_tipo:
        print("Erros semanticos encontrados. Corrija o arquivo .txt primeiro.")
        return

    arvore_atrib = gerarArvoreAtribuida(arvore_inicial, tabela)

    nome_base = os.path.basename(nome_arquivo)
    nome_saida = f"build/{nome_base.replace('.txt', '_morse.s')}"
    
    gerarAssemblyMorse(arvore_atrib, nome_saida)

def main():
    if len(sys.argv) < 2:
        print("Uso: python morse.py <arquivo_teste.txt>")
    else:
        compilarParaMorse(sys.argv[1])

if __name__ == "__main__":
    main()