import sys

from semantico import (
    prepararEntradaSemantica,
    decorarArvoreComLinhas,
    construirTabelaSimbolos,
    verificarTipos,
    gerarArvoreAtribuida,
    gerarAssembly
)

# ==========================================
# DICIONÁRIO MORSE
# ==========================================

MORSE = {
    'A': '.-',
    'B': '-...',
    'C': '-.-.',
    'D': '-..',
    'E': '.',
    'F': '..-.',
    'G': '--.',
    'H': '....',
    'I': '..',
    'J': '.---',
    'K': '-.-',
    'L': '.-..',
    'M': '--',
    'N': '-.',
    'O': '---',
    'P': '.--.',
    'Q': '--.-',
    'R': '.-.',
    'S': '...',
    'T': '-',
    'U': '..-',
    'V': '...-',
    'W': '.--',
    'X': '-..-',
    'Y': '-.--',
    'Z': '--..',
    ' ': ' '
}

# ==========================================
# CONVERTE ASCII -> MORSE
# ==========================================

def ascii_para_morse(ascii_code):
    caractere = chr(int(ascii_code))

    if caractere in MORSE:
        return MORSE[caractere]

    return ""

# ==========================================
# GERA INSTRUÇÕES MORSE
# ==========================================

def gerar_codigo_morse(lista_ascii):
    linhas = []

    for codigo in lista_ascii:

        morse = ascii_para_morse(codigo)

        # espaço entre palavras
        if morse == " ":
            linhas.append("    BL espaco_palavra")
            continue

        for simbolo in morse:

            if simbolo == ".":
                linhas.append("    BL ponto")

            elif simbolo == "-":
                linhas.append("    BL traco")

            linhas.append("    BL espaco_interno")

        linhas.append("    BL espaco_letra")

    return linhas

# ==========================================
# GERA O ASSEMBLY FINAL
# ==========================================

def gerarAssemblyMorse(lista_ascii, nome_saida):

    codigo = []

    codigo.append(".global _start")
    codigo.append("")
    codigo.append("_start:")
    codigo.append("")

    codigo.extend(gerar_codigo_morse(lista_ascii))

    codigo.append("")
    codigo.append("fim:")
    codigo.append("    B fim")
    codigo.append("")

    # --------------------------------------
    # PONTO = 300 ms
    # --------------------------------------

    codigo.append("ponto:")
    codigo.append("    PUSH {LR}")
    codigo.append("    BL led_on")
    codigo.append("    LDR R0, =3000000")
    codigo.append("    BL delay")
    codigo.append("    BL led_off")
    codigo.append("    POP {LR}")
    codigo.append("    BX LR")
    codigo.append("")

    # --------------------------------------
    # TRAÇO = 600 ms
    # --------------------------------------

    codigo.append("traco:")
    codigo.append("    PUSH {LR}")
    codigo.append("    BL led_on")
    codigo.append("    LDR R0, =6000000")
    codigo.append("    BL delay")
    codigo.append("    BL led_off")
    codigo.append("    POP {LR}")
    codigo.append("    BX LR")
    codigo.append("")

    # --------------------------------------
    # ESPAÇOS
    # --------------------------------------

    codigo.append("espaco_interno:")
    codigo.append("    LDR R0, =4500000")
    codigo.append("    B delay")
    codigo.append("")

    codigo.append("espaco_letra:")
    codigo.append("    LDR R0, =9000000")
    codigo.append("    B delay")
    codigo.append("")

    codigo.append("espaco_palavra:")
    codigo.append("    LDR R0, =20000000")
    codigo.append("    B delay")
    codigo.append("")

    # --------------------------------------
    # LED ON
    # --------------------------------------

    codigo.append("led_on:")
    codigo.append("    LDR R1, =0xFF200000")
    codigo.append("    MOV R2, #0x3FF")
    codigo.append("    STR R2, [R1]")
    codigo.append("    BX LR")
    codigo.append("")

    # --------------------------------------
    # LED OFF
    # --------------------------------------

    codigo.append("led_off:")
    codigo.append("    LDR R1, =0xFF200000")
    codigo.append("    MOV R2, #0")
    codigo.append("    STR R2, [R1]")
    codigo.append("    BX LR")
    codigo.append("")

    # --------------------------------------
    # DELAY
    # --------------------------------------

    codigo.append("delay:")
    codigo.append("delay_loop:")
    codigo.append("    SUBS R0, R0, #1")
    codigo.append("    BNE delay_loop")
    codigo.append("    BX LR")

    with open(nome_saida, "w", encoding="utf-8") as arquivo:
        arquivo.write("\n".join(codigo))

    print(f"Assembly Morse salvo em {nome_saida}")

# ==========================================
# EXEMPLO
# ==========================================

if __name__ == "__main__":

    # EDU MELO
    ascii_nome = [
        69, 68, 85,
        32,
        77, 69, 76, 79
    ]

    gerarAssemblyMorse(ascii_nome, "morse.s")