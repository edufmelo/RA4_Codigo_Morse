import sys
from semantico import (
    prepararEntradaSemantica, 
    decorarArvoreComLinhas, 
    construirTabelaSimbolos, 
    verificarTipos, 
    gerarArvoreAtribuida,
    gerarAssembly
)

# Dicionário Morse utilizado na geração do assembly
# Cada letra é convertida para uma representação hexadecimal

MORSE_PYTHON = {
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
    """Converte um padrão Morse para uma máscara hexadecimal"""
    hex_str = ""
    for char in padrao:
        if char == '.': hex_str += "1"
        elif char == '-': hex_str += "2"
    
    hex_str = hex_str.ljust(8, '0')
    return f"0x{hex_str}"

def gerarDicionarioMorse():
    """Gera a tabela Morse que será adicionada na seção de dados"""
    linhas_asm = [
        "    @ --- SECAO DE DADOS (DICIONARIO MORSE) ---",
        "    .align 2",
        "    morse_dict:"
    ]
    for ascii_code in range(48, 91):
        char = chr(ascii_code)
        if char in MORSE_PYTHON:
            hex_val = padraoParaHexadecimal(MORSE_PYTHON[char])
            linhas_asm.append(f"    .word {hex_val}  @ Indice {ascii_code-48} -> Letra {char}")
        else:
            linhas_asm.append(f"    .word 0x00000000  @ Indice {ascii_code-48} -> Nulo")
    return linhas_asm

# Geração do código Morse e integração com o assembly produzido pelo compilador
def gerarAssemblyMorse(arvore_atribuida, nome_arquivo):
    codigo_base = gerarAssembly(arvore_atribuida, nome_arquivo)
    dicionario_dinamico = gerarDicionarioMorse()
    
    # Verifica se a quantidade de resultados ultrapassa o espaço reservado
    qtd_resultados = sum(1 for linha in codigo_base if "numResultados++" in linha)
    if qtd_resultados > 100:
        print(f"\n[AVISO] O programa exige {qtd_resultados} espaços de memória.")
        print("A secao .space aloca apenas 800 bytes (100 doubles).")
        print("Risco de Buffer Overflow no CPULator!\n")

    rotina_morse = [
        "    @ =========================================================",
        "    @ CONFIGURACAO DE VELOCIDADE DA SIMULACAO",
        "    @ DELAY_SCALE = 10000 (Tempo real).",
        "    @ Para deixar a simulação MAIS DEVAGAR, aumente (ex: 50000).",
        "    @ Para deixar a simulação MAIS RÁPIDA, diminua (ex: 1000).",
        "    .equ DELAY_SCALE, 15000",
        "    @ =========================================================",
        "    @ Rotina responsável por exibir o resultado em código Morse",
        "    @ utilizando os LEDs",
        "    @ =========================================================",
        "    LDR R4, =numResultados",
        "    LDR R4, [R4]             @ Quantidade de resultados armazenados",
        "    LDR R5, =resultados      @ Início do vetor de resultados",
        "    MOV R6, #0               @ Índice atual",
        "    LDR R11, =0xFF200000     @ Endereço dos LEDs",
        "",
        "loop_letras:",
        "    CMP R6, R4",
        "    BGE fim_morse            @ if (i >= tamanho) break",
        "",
        "    VLDR D0, [R5]            ",
        "    VCVT.S32.F64 S0, D0      @ Converte o valor armazenado para inteiro ASCII",
        "    VMOV R7, S0              @ R7 guarda o caractere ASCII",
        "",
        "    CMP R7, #32              @ ASCII ' ' = 32 (Espaco entre palavras)",
        "    BEQ espaco_palavra",
        "",
        "    SUB R7, R7, #48          @ Indice = ASCII - 48",
        "    LSL R7, R7, #2           @ offset = indice * 4 bytes",
        "    LDR R8, =morse_dict",
        "    LDR R9, [R8, R7]         @ Busca o padrão Morse correspondente ao caractere",
        "",
        "loop_simbolos:",
        "    CMP R9, #0               ",
        "    BEQ proxima_letra        @ Se não houver mais símbolos, passa para a próxima letra",
        "",
        "    LSR R10, R9, #28         @ Lê o próximo símbolo do padrão Morse",
        "    LSL R9, R9, #4           @ Desloca os proximos simbolos",
        "",
        "    CMP R10, #1",
        "    BLEQ pisca_ponto",
        "    CMP R10, #2",
        "    BLEQ pisca_traco",
        "",
        "    CMP R9, #0               ",
        "    BEQ proxima_letra        @ Evita adicionar atraso após o último símbolo da letra",
        "",
        "    LDR R0, =4500000         @ Delay DENTRO da letra (450ms)",
        "    BL delay",
        "    B loop_simbolos",
        "",
        "proxima_letra:",
        "    LDR R0, =(900 * DELAY_SCALE)         @ Delay ENTRE letras (900ms)",
        "    BL delay",
        "    B avanca_array",
        "",
        "espaco_palavra:",
        "    LDR R0, =(1100 * DELAY_SCALE)       @ Espaço entre palavras (ajustado para totalizar 2000 ms)",
        "    BL delay",
        "",
        "avanca_array:",
        "    ADD R5, R5, #8           @ Avanca ponteiro de memoria",
        "    ADD R6, R6, #1           @ i++",
        "    B loop_letras",
        "",
        "    @ =========================================================",
        "    @ Rotinas de controle dos LEDs e temporização",
        "    @ =========================================================",
        "pisca_ponto:",
        "    MOV R1, #0x3FF           ",
        "    STR R1, [R11]",
        "    LDR R0, =(300 * DELAY_SCALE)         ",
        "    B apaga_led",
        "",
        "pisca_traco:",
        "    MOV R1, #0x3FF           ",
        "    STR R1, [R11]",
        "    LDR R0, =(600 * DELAY_SCALE)         ",
        "",
        "apaga_led:",
        "    PUSH {LR}                ",
        "    BL delay",
        "    MOV R1, #0               ",
        "    STR R1, [R11]",
        "    POP {PC}                 ",
        "",
        "delay:",
        "    SUBS R0, R0, #1",
        "    BNE delay",
        "    BX LR",
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
    nome_saida = nome_arquivo.replace('.txt', '_morse.s')
    
    gerarAssemblyMorse(arvore_atrib, nome_saida)

def main():
    if len(sys.argv) < 2:
        print("Uso: python morse.py <arquivo_teste.txt>")
    else:
        compilarParaMorse(sys.argv[1])

if __name__ == "__main__":
    main()