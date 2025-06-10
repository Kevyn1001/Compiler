# Teste: Comparação de Caracteres

## Descrição
Verifica se o compilador permite comparação de igualdade/inegualdade (!=) entre dois valores do tipo char, gerando o código intermediário correto.

### Código na Linguagem
```c
char C1;
char C2;
bool B;
B = C1 != C2;
```

### Observações

- Deve gerar temporários para C1 e C2 (ambos char) e comparar com !=.
- Resultado da comparação (true/false) deve ser armazenado em um temporário de tipo bool (internamente int).
- Se tiposCompativeis não permitir CHAR em !=, deve sinalizar erro.