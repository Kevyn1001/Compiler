# Teste: Aritmética sobre Caracteres

## Descrição
Este teste confirma se o compilador aceita operações aritméticas entre dois valores char, gerando um temporário de tipo adequado (geralmente int) ou sinalizando erro de tipos, conforme a especificação.

### Código na Linguagem
```c
char C1;
char C2;
int R;
R = C1 + C2;
```

### Observações
- O compilador deve ler C1 e C2 como char, promover cada um para um temporário de tipo char (ou diretamente para int), e então somar.
- Resultado final precisa ser atribuído a R (tipo int).
- Se não aceitar char + char, deve sinalizar erro de tipos.