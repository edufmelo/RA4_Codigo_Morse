# Árvore Sintática Atribuída (Aumentada)

```text
programa
└── comando_lista
    ├── comando
    │   ├── ABRE_PAREN (()
    │   ├── conteudo_comando [tipo: void, cat: controle]
    │   │   └── KEYWORD_START (START) [tipo: void, cat: controle]
    │   └── FECHA_PAREN ())
    └── comando_lista
        ├── comando
        │   ├── ABRE_PAREN (()
        │   ├── conteudo_comando [tipo: real, cat: expressao]
        │   │   ├── NUMERO (49.0) [tipo: real, cat: literal]
        │   │   └── sufixo_numero
        │   │       ├── NUMERO (0.0) [tipo: real, cat: literal]
        │   │       └── operador_final
        │   │           └── OPERADOR (+) [tipo: real, cat: operador_aritmetico]
        │   └── FECHA_PAREN ())
        └── comando_lista
            ├── comando
            │   ├── ABRE_PAREN (()
            │   ├── conteudo_comando [tipo: real, cat: expressao]
            │   │   ├── NUMERO (32.0) [tipo: real, cat: literal]
            │   │   └── sufixo_numero
            │   │       ├── NUMERO (0.0) [tipo: real, cat: literal]
            │   │       └── operador_final
            │   │           └── OPERADOR (+) [tipo: real, cat: operador_aritmetico]
            │   └── FECHA_PAREN ())
            └── comando_lista
                ├── comando
                │   ├── ABRE_PAREN (()
                │   ├── conteudo_comando [tipo: real, cat: expressao]
                │   │   ├── NUMERO (19.0) [tipo: real, cat: literal]
                │   │   └── sufixo_numero
                │   │       ├── NUMERO (50.0) [tipo: real, cat: literal]
                │   │       └── operador_final
                │   │           └── OPERADOR (+) [tipo: real, cat: operador_aritmetico]
                │   └── FECHA_PAREN ())
                └── comando_lista
                    ├── comando
                    │   ├── ABRE_PAREN (()
                    │   ├── conteudo_comando [tipo: real, cat: expressao]
                    │   │   ├── NUMERO (50.0) [tipo: real, cat: literal]
                    │   │   └── sufixo_numero
                    │   │       ├── NUMERO (18.0) [tipo: real, cat: literal]
                    │   │       └── operador_final
                    │   │           └── OPERADOR (+) [tipo: real, cat: operador_aritmetico]
                    │   └── FECHA_PAREN ())
                    └── comando_lista
                        ├── comando
                        │   ├── ABRE_PAREN (()
                        │   ├── conteudo_comando [tipo: real, cat: expressao]
                        │   │   ├── NUMERO (86.0) [tipo: real, cat: literal]
                        │   │   └── sufixo_numero
                        │   │       ├── NUMERO (1.0) [tipo: real, cat: literal]
                        │   │       └── operador_final
                        │   │           └── OPERADOR (-) [tipo: real, cat: operador_aritmetico]
                        │   └── FECHA_PAREN ())
                        └── comando_lista
                            ├── comando
                            │   ├── ABRE_PAREN (()
                            │   ├── conteudo_comando [tipo: real, cat: expressao]
                            │   │   ├── NUMERO (32.0) [tipo: real, cat: literal]
                            │   │   └── sufixo_numero
                            │   │       ├── NUMERO (0.0) [tipo: real, cat: literal]
                            │   │       └── operador_final
                            │   │           └── OPERADOR (+) [tipo: real, cat: operador_aritmetico]
                            │   └── FECHA_PAREN ())
                            └── comando_lista
                                ├── comando
                                │   ├── ABRE_PAREN (()
                                │   ├── conteudo_comando [tipo: real, cat: expressao]
                                │   │   ├── NUMERO (50.0) [tipo: real, cat: literal]
                                │   │   └── sufixo_numero
                                │   │       ├── NUMERO (27.0) [tipo: real, cat: literal]
                                │   │       └── operador_final
                                │   │           └── OPERADOR (+) [tipo: real, cat: operador_aritmetico]
                                │   └── FECHA_PAREN ())
                                └── comando_lista
                                    ├── comando
                                    │   ├── ABRE_PAREN (()
                                    │   ├── conteudo_comando [tipo: real, cat: expressao]
                                    │   │   ├── NUMERO (50.0) [tipo: real, cat: literal]
                                    │   │   └── sufixo_numero
                                    │   │       ├── NUMERO (19.0) [tipo: real, cat: literal]
                                    │   │       └── operador_final
                                    │   │           └── OPERADOR (+) [tipo: real, cat: operador_aritmetico]
                                    │   └── FECHA_PAREN ())
                                    └── comando_lista
                                        ├── comando
                                        │   ├── ABRE_PAREN (()
                                        │   ├── conteudo_comando [tipo: real, cat: expressao]
                                        │   │   ├── NUMERO (50.0) [tipo: real, cat: literal]
                                        │   │   └── sufixo_numero
                                        │   │       ├── NUMERO (26.0) [tipo: real, cat: literal]
                                        │   │       └── operador_final
                                        │   │           └── OPERADOR (+) [tipo: real, cat: operador_aritmetico]
                                        │   └── FECHA_PAREN ())
                                        └── comando_lista
                                            ├── comando
                                            │   ├── ABRE_PAREN (()
                                            │   ├── conteudo_comando [tipo: real, cat: expressao]
                                            │   │   ├── NUMERO (50.0) [tipo: real, cat: literal]
                                            │   │   └── sufixo_numero
                                            │   │       ├── NUMERO (29.0) [tipo: real, cat: literal]
                                            │   │       └── operador_final
                                            │   │           └── OPERADOR (+) [tipo: real, cat: operador_aritmetico]
                                            │   └── FECHA_PAREN ())
                                            └── comando_lista
                                                ├── comando
                                                │   ├── ABRE_PAREN (()
                                                │   ├── conteudo_comando [tipo: void, cat: controle]
                                                │   │   └── KEYWORD_END (END) [tipo: void, cat: controle]
                                                │   └── FECHA_PAREN ())
                                                └── comando_lista
                                                    └── ε ()
```
