# Fase 4 - Gerador de Código Morse (Assembly ARMv7)

## Informações do Projeto

* **Instituição:** PUCPR - Pontifícia Universidade Católica do Paraná
* **Ano:** 2026 - 1º Semestre
* **Disciplina:** Linguagens Formais e Compiladores
* **Professor:** Valter Klein Junior
* **Aluno:** Eduardo Ferreira de Melo (`edufmelo`)
* **Linguagem de implementação:** Python 3 e Assembly ARMv7

## Objetivo

Este projeto implementa a quarta e última fase da disciplina: a **Geração de Código e Integração com Hardware**. 

O compilador construído nas fases anteriores (Léxico, Sintático e Semântico) foi integrado a um *Runtime Environment* desenvolvido em Assembly ARMv7. O objetivo final é processar uma entrada de texto, compilar a fita RPN e exibir o resultado visualmente através dos LEDs da placa **DE1-SoC** (simulada no CPULator), utilizando o padrão internacional de Código Morse.

## Arquitetura de Pastas

Para manter a organização e rastreabilidade, o repositório adota a seguinte arquitetura:

* **Raiz do Projeto:** Código-fonte do compilador (`lexico.py`, `sintatico.py`, `semantico.py` e `morse.py`).
* `/docs`: Documentação estática do projeto, como a gramática da linguagem (`gramatica.md`) e o `README.md`.
* `/entradas`: Arquivos de texto originais que serão compilados (ex: `edumelo.txt`).
* `/relatorios`: Relatórios de tipos, tabela de símbolos, tokens gerados, logs e erros.
* `/build`: Diretório de saída contendo o arquivo final em código de máquina (`.s`).
* `/funcoesTeste`: Scripts para execução modular de testes unitários.

## Como Executar

O programa deve ser executado pela linha de comando a partir da raiz do projeto, informando o arquivo de entrada desejado. 

Exemplo de compilação:

```bash
python morse.py entradas/edumelo.txt
```

O arquivo de código de máquina final será gerado automaticamente na pasta de *build*: `build/edumelo_morse.s`

Copie o conteúdo deste arquivo `.s` e cole no simulador **CPULator** para executar e visualizar os LEDs.

## Destaques Técnicos e Otimizações

A geração de código foi construída simulando arquiteturas de compiladores reais, separando o processamento em tempo de compilação (*compile-time*) do tempo de execução (*runtime*). 

1. **Otimização de Compile-Time (Data Packing/Bitmasking):**
   Ao invés de carregar *strings* literais (como `.-.`) na memória do processador, o Python converte previamente cada símbolo Morse numa máscara hexadecimal de 32 bits (ex: `0x12100000`). Isto permite que a CPU identifique o pulso elétrico correto utilizando apenas instruções nativas e rápidas de deslocamento de bits (*Logical Shift* - `LSR` e `LSL`).

2. **Gerenciamento Preciso de Clock (Temporização):**
   Os espaços de exibição respeitam rigorosamente a proporção do Código Morse (15.000 ciclos por milissegundo calibrados no CPULator):
   * Ponto: `300ms` | Traço: `600ms`
   * Espaço intra-letra: `450ms` | Entre letras: `900ms` | Entre palavras: `2000ms`
   * **Compensação de Estado:** O compilador calcula matematicamente a compensação do espaço de palavras subtraindo o atraso natural deixado pelo fechamento da letra anterior.

3. **Parametrização de Velocidade:**
   A velocidade de simulação não utiliza *Magic Numbers*. O controlo de tempo é parametrizado via `.equ DELAY_SCALE, 15000`. Alterar este valor permite acelerar ou colocar a simulação em "câmara lenta" de forma global e proporcional em todo o código.

4. **Prevenção de Buffer Overflow:**
   O script analisa previamente as alocações da diretiva `.space` no Assembly, abortando o salvamento e emitindo um aviso de segurança caso a entrada exija mais memória estática do que o ambiente ARMv7 reservou.