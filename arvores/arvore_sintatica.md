# Árvore Sintática (Derivação)

## Resultado do entradas/edumelo.txt:

```text
programa
└── comando_lista
    ├── comando
    │   ├── ABRE_PAREN (()
    │   ├── conteudo_comando
    │   │   └── KEYWORD_START (START)
    │   └── FECHA_PAREN ())
    └── comando_lista
        ├── comando
        │   ├── ABRE_PAREN (()
        │   ├── conteudo_comando
        │   │   ├── NUMERO (49.0)
        │   │   └── sufixo_numero
        │   │       ├── NUMERO (0.0)
        │   │       └── operador_final
        │   │           └── OPERADOR (+)
        │   └── FECHA_PAREN ())
        └── comando_lista
            ├── comando
            │   ├── ABRE_PAREN (()
            │   ├── conteudo_comando
            │   │   ├── NUMERO (32.0)
            │   │   └── sufixo_numero
            │   │       ├── NUMERO (0.0)
            │   │       └── operador_final
            │   │           └── OPERADOR (+)
            │   └── FECHA_PAREN ())
            └── comando_lista
                ├── comando
                │   ├── ABRE_PAREN (()
                │   ├── conteudo_comando
                │   │   ├── NUMERO (19.0)
                │   │   └── sufixo_numero
                │   │       ├── NUMERO (50.0)
                │   │       └── operador_final
                │   │           └── OPERADOR (+)
                │   └── FECHA_PAREN ())
                └── comando_lista
                    ├── comando
                    │   ├── ABRE_PAREN (()
                    │   ├── conteudo_comando
                    │   │   ├── NUMERO (50.0)
                    │   │   └── sufixo_numero
                    │   │       ├── NUMERO (18.0)
                    │   │       └── operador_final
                    │   │           └── OPERADOR (+)
                    │   └── FECHA_PAREN ())
                    └── comando_lista
                        ├── comando
                        │   ├── ABRE_PAREN (()
                        │   ├── conteudo_comando
                        │   │   ├── NUMERO (86.0)
                        │   │   └── sufixo_numero
                        │   │       ├── NUMERO (1.0)
                        │   │       └── operador_final
                        │   │           └── OPERADOR (-)
                        │   └── FECHA_PAREN ())
                        └── comando_lista
                            ├── comando
                            │   ├── ABRE_PAREN (()
                            │   ├── conteudo_comando
                            │   │   ├── NUMERO (32.0)
                            │   │   └── sufixo_numero
                            │   │       ├── NUMERO (0.0)
                            │   │       └── operador_final
                            │   │           └── OPERADOR (+)
                            │   └── FECHA_PAREN ())
                            └── comando_lista
                                ├── comando
                                │   ├── ABRE_PAREN (()
                                │   ├── conteudo_comando
                                │   │   ├── NUMERO (50.0)
                                │   │   └── sufixo_numero
                                │   │       ├── NUMERO (27.0)
                                │   │       └── operador_final
                                │   │           └── OPERADOR (+)
                                │   └── FECHA_PAREN ())
                                └── comando_lista
                                    ├── comando
                                    │   ├── ABRE_PAREN (()
                                    │   ├── conteudo_comando
                                    │   │   ├── NUMERO (50.0)
                                    │   │   └── sufixo_numero
                                    │   │       ├── NUMERO (19.0)
                                    │   │       └── operador_final
                                    │   │           └── OPERADOR (+)
                                    │   └── FECHA_PAREN ())
                                    └── comando_lista
                                        ├── comando
                                        │   ├── ABRE_PAREN (()
                                        │   ├── conteudo_comando
                                        │   │   ├── NUMERO (50.0)
                                        │   │   └── sufixo_numero
                                        │   │       ├── NUMERO (26.0)
                                        │   │       └── operador_final
                                        │   │           └── OPERADOR (+)
                                        │   └── FECHA_PAREN ())
                                        └── comando_lista
                                            ├── comando
                                            │   ├── ABRE_PAREN (()
                                            │   ├── conteudo_comando
                                            │   │   ├── NUMERO (50.0)
                                            │   │   └── sufixo_numero
                                            │   │       ├── NUMERO (29.0)
                                            │   │       └── operador_final
                                            │   │           └── OPERADOR (+)
                                            │   └── FECHA_PAREN ())
                                            └── comando_lista
                                                ├── comando
                                                │   ├── ABRE_PAREN (()
                                                │   ├── conteudo_comando
                                                │   │   └── KEYWORD_END (END)
                                                │   └── FECHA_PAREN ())
                                                └── comando_lista
                                                    └── ε ()
```
